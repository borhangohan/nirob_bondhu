import 'package:flutter/material.dart';
import '../models/intents.dart';
import '../services/emergency_service.dart';
import '../services/nlp_service.dart';
import '../services/stt_service.dart';
import '../services/tts_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SttService _sttService = SttService();
  final TtsService _ttsService = TtsService();
  final NlpService _nlpService = NlpService();
  final EmergencyService _emergencyService = EmergencyService();
  List<Map<String, String>> _conversation = [];

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    await _sttService.initialize();
    await _nlpService.loadModel();
  }

  Future<void> _listenAndRespond() async {
    try {
      final userInput = await _sttService.listenOnce();
      if (userInput.isEmpty) return;

      setState(() {
        _conversation.add({'user': userInput});
      });

      // Classify intent
      final intent = await _nlpService.classifyText(userInput);
      final response = _nlpService.generateResponse(intent);

      // Speak the response
      await _ttsService.speak(response);

      setState(() {
        _conversation.add({'ai': response});
      });

      // Handle emergency intent
      if (intent == IntentType.emergency) {
        _emergencyService.triggerEmergency();
      }
    } catch (e) {
      print("Error in _listenAndRespond: $e");
      await _ttsService.speak("দুঃখিত, আমি বুঝতে পারিনি। আবার চেষ্টা করুন।");
    }
  }

  @override
  void dispose() {
    _sttService.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('নিরব বন্ধু')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _conversation.length,
              itemBuilder: (context, index) {
                final message = _conversation[index];
                return ListTile(
                  title: Text(
                    message['user'] ?? message['ai']!,
                    style: TextStyle(
                      color: message['user'] != null ? Colors.blue : Colors.green,
                    ),
                  ),
                  subtitle: Text(message['user'] != null ? 'আপনি' : 'নিরব'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _listenAndRespond,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('শুনুন', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
