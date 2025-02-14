import 'package:flutter/material.dart';
import 'processed_text_screen.dart';

class VoiceRecordScreen extends StatefulWidget {
  const VoiceRecordScreen({super.key});

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

    Future.delayed(const Duration(seconds: 13), () {
      setState(() {
        _isRecording = false;
        _transcribedText =
            "There is a mistake, 3 Bottles of Pack Frutty Kids not Pack Frutty, and 2 Bottles of Ramy UP 125 ML on 3 shelves";
      });
    });
  }

  void _processText() async {
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
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.orange),
              ),
              const SizedBox(height: 16),
              const Text(
                "Processing Input...",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );

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
      appBar: AppBar(
        title: const Text("Voice Recorder"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Record your voice below:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Center(
              child: InkWell(
                onTap: _isRecording ? null : _startRecording,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.deepOrange, Colors.orange],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      _isRecording ? "Recording..." : "Start Recording",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
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
                child: InkWell(
                  onTap: _processText,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.deepOrange, Colors.orange],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "Process Text",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
