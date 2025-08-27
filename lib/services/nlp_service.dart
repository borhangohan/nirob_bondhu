import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/services.dart';
import 'intents.dart'; // Import the IntentType enum

class NlpService {
  late Interpreter _interpreter;
  bool _isModelLoaded = false;
  final List<String> _intents = ['story', 'news', 'reminder', 'emergency', 'smalltalk'];
  final List<String> _bengaliVocabulary = [
    'গল্প', // story
    'খবর', // news
    'রিমাইন্ডার', // reminder
    'জরুরি', // emergency
    'আলাপ', // smalltalk
  ];

  // Load the TFLite model from assets
  Future<void> loadModel() async {
    try {
      final modelPath = 'assets/models/intent_model.tflite';
      final modelData = await rootBundle.load(modelPath);
      final modelBuffer = modelData.buffer.asUint8List();
      _interpreter = await Interpreter.fromBuffer(modelBuffer);
      _isModelLoaded = true;
      print("TFLite model loaded successfully.");
    } catch (e) {
      print("Failed to load TFLite model: $e");
      throw Exception("Model loading failed");
    }
  }

  // Classify user input text into an intent
  Future<IntentType> classifyText(String text) async {
    if (!_isModelLoaded) {
      await loadModel();
    }

    // Preprocess text using one-hot encoding
    var input = _preprocessText(text);

    // Allocate output buffer
    var output = List.filled(_intents.length, 0).reshape([1, _intents.length]);

    // Run inference
    _interpreter.run(input, output);

    // Postprocess output to get the intent
    return _postprocessOutput(output);
  }

  // Generate a response based on the intent
  String generateResponse(IntentType intent, {String? details}) {
    switch (intent) {
      case IntentType.story:
        return "আপনার জন্য একটি গল্প: ${details ?? 'একবার একটা ছিল...'}";
      case IntentType.news:
        return "এখানে সর্বশেষ খবর: ${details ?? 'কোনো খবর নেই।'}";
      case IntentType.reminder:
        return "রিমাইন্ডার সেট করা হয়েছে: ${details ?? 'বিস্তারিত নেই।'}";
      case IntentType.emergency:
        return "জরুরি অবস্থা সনাক্ত হয়েছে! সাহায্যের জন্য কল করা হচ্ছে।";
      case IntentType.smalltalk:
        return "হ্যালো! আপনাকে কীভাবে সাহায্য করতে পারি?";
      default:
        return "আমি বুঝতে পারিনি। আবার বলুন?";
    }
  }

  // Preprocess text using one-hot encoding
  List<double> _preprocessText(String text) {
    // Initialize a zero vector for one-hot encoding
    List<double> oneHot = List.filled(_bengaliVocabulary.length, 0.0);

    // Split the input text into words
    final List<String> words = text.toLowerCase().split(' ');

    // Set the corresponding index to 1 for each word in the vocabulary
    for (var word in words) {
      final index = _bengaliVocabulary.indexOf(word);
      if (index != -1) {
        oneHot[index] = 1.0;
      }
    }

    return oneHot;
  }

  // Postprocess model output to get the intent
  IntentType _postprocessOutput(List output) {
    // Flatten the output list
    final flatOutput = output.first as List;
    // Find the index of the highest value
    final maxIndex = flatOutput.indexOf(flatOutput.reduce((a, b) => a > b ? a : b));
    // Return the corresponding IntentType
    return IntentType.values[maxIndex];
  }
}
