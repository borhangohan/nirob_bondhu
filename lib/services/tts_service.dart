import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _tts = FlutterTts();

  TtsService() {
    _tts.setLanguage("bn-BD"); // Bengali
    _tts.setSpeechRate(0.9);
  }

  Future<void> speak(String text) async {
    await _tts.speak(text);
  }
}
