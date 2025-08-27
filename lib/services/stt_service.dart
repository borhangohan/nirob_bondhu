import 'package:speech_to_text/speech_to_text.dart' as stt;

class SttService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isInitialized = false;

  Future<void> initialize() async {
    try {
      _isInitialized = await _speech.initialize(
        onStatus: (status) => print('Speech recognition status: $status'),
        onError: (error) => print('Speech recognition error: $error'),
      );
      if (_isInitialized) {
        print("Speech recognition initialized successfully.");
      } else {
        throw Exception("Failed to initialize speech recognition");
      }
    } catch (e) {
      print("Failed to initialize speech recognition: $e");
      throw Exception("Speech recognition initialization failed");
    }
  }

  Future<String> listenOnce() async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      bool available = await _speech.listen(
        onResult: (result) {},
        listenFor: const Duration(seconds: 10),
        pauseFor: const Duration(seconds: 5),
        localeId: 'bn_IN', // Bengali (India)
        cancelOnError: true,
        listenMode: stt.ListenMode.confirmation,
      );

      if (!available) {
        print("Speech recognition not available");
        return "";
      }

      final recognizedText = await Future.delayed(
        const Duration(seconds: 5),
            () => _speech.lastRecognizedWords,
      );

      return recognizedText;
    } catch (e) {
      print("Error during speech recognition: $e");
      return "";
    }
  }

  void dispose() {
    _speech.stop();
  }
}
