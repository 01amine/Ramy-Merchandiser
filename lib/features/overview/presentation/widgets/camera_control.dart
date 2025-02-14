import 'package:flutter/material.dart';

class CameraControls extends StatelessWidget {
  final Function() onCapture;
  final Function() onFlashToggle;
  final Function() onCameraSwitch;
  final Function() onVoiceCount;
  final bool isFlashOn;
  
  const CameraControls({
    Key? key,
    required this.onCapture,
    required this.onFlashToggle,
    required this.onCameraSwitch,
    required this.onVoiceCount,
    this.isFlashOn = false,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.black87,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  isFlashOn ? Icons.flash_on : Icons.flash_off,
                  color: Colors.white,
                ),
                onPressed: onFlashToggle,
              ),
              GestureDetector(
                onTap: onCapture,
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.flip_camera_ios, color: Colors.white),
                onPressed: onCameraSwitch,
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextButton.icon(
            onPressed: onVoiceCount,
            icon: const Icon(Icons.mic, color: Colors.white),
            label: const Text(
              'Start Voice Count',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
