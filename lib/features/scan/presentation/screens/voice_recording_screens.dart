import 'package:flutter/material.dart';
import 'processed_text_screen.dart';

class VoiceRecordScreen extends StatefulWidget {
  const VoiceRecordScreen({Key? key}) : super(key: key);

  @override
  _VoiceRecordScreenState createState() => _VoiceRecordScreenState();
}

class _VoiceRecordScreenState extends State<VoiceRecordScreen> {
  String _transcribedText = "";
  bool _isRecording = false;

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _transcribedText = "Listening...";
    });

    // Simulate voice recording delay
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isRecording = false;
        _transcribedText =
            "3 Bottles of Pack Frutty Kids 20 CL on two shelves, 2 Bottles of Ramy UP 125 ML on 3 shelves";
      });
    });
  }

  void _processText() async {
    // Show a popup with an animated loader while processing the text
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 10,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor:
                          const AlwaysStoppedAnimation(Colors.deepPurple),
                      strokeWidth: 6,
                    ),
                    const Icon(
                      Icons.record_voice_over,
                      color: Colors.deepPurple,
                      size: 28,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Processing Input...",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please wait while we analyze your input.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Simulate text processing delay
    await Future.delayed(const Duration(seconds: 2));

    Navigator.of(context).pop();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProcessedTextScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Voice Recorder")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Record your voice below:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _isRecording ? null : _startRecording,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text(
                  _isRecording ? "Recording..." : "Start Recording",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  "Recognized Text: $_transcribedText",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (!_isRecording &&
                _transcribedText.isNotEmpty &&
                _transcribedText != "Listening...")
              Center(
                child: ElevatedButton(
                  onPressed: _processText,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  child: const Text(
                    "Process Text",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
