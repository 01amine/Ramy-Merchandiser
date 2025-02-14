import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import '../../../overview/presentation/widgets/camera_control.dart';
import 'processed_image_screen.dart';
import 'voice_recording_screens.dart';

class ScanScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const ScanScreen({super.key, required this.cameras});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with TickerProviderStateMixin {
  late CameraController _controller;
  late AnimationController _flashAnimationController;
  late Animation<double> _flashAnimation;
  bool _isFlashOn = false;
  int _selectedCamera = 0;
  bool _isProcessing = false;

  void _initializeCamera() async {
    try {
      _controller = CameraController(
        widget.cameras[_selectedCamera],
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _controller.initialize();
      await _controller.lockCaptureOrientation(DeviceOrientation.portraitUp);

      if (!mounted) return;
      setState(() {});
    } catch (e) {
      debugPrint("Camera initialization error: $e");
    }
  }

  Future<void> _switchCamera() async {
    final cameraIndex = (_selectedCamera + 1) % widget.cameras.length;
    await _controller.dispose();
    setState(() => _selectedCamera = cameraIndex);
    _initializeCamera();
  }

  Future<void> _toggleFlash() async {
    if (!_controller.value.isInitialized) return;
    try {
      await _controller
          .setFlashMode(_isFlashOn ? FlashMode.off : FlashMode.torch);
      setState(() => _isFlashOn = !_isFlashOn);
    } catch (e) {
      debugPrint("Flash toggle error: $e");
    }
  }

  void _setupAnimations() {
    _flashAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _flashAnimation = CurvedAnimation(
      parent: _flashAnimationController,
      curve: Curves.easeInOut,
    );
  }

  Future<void> _captureImage() async {
    if (!_controller.value.isInitialized) return;
    try {
      _flashAnimationController
          .forward()
          .then((_) => _flashAnimationController.reverse());
      final image = await _controller.takePicture();
      _showLoadingPopup();
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProcessedImageScreen(imagePath: image.path)),
      );
    } catch (e) {
      debugPrint("Error capturing image: $e");
    }
  }

  void _showLoadingPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                      valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
                      strokeWidth: 6,
                    ),
                    Icon(Icons.image_search,
                        color: Colors.deepPurple, size: 28),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Processing Image...",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please wait a moment while we analyze your image.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _setupAnimations();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: RotatedBox(
              quarterTurns: _controller.description.sensorOrientation ~/ 90,
              child: CameraPreview(_controller),
            ),
          ),
          AnimatedBuilder(
            animation: _flashAnimation,
            builder: (context, child) => Opacity(
              opacity: _flashAnimation.value,
              child: Container(color: Colors.white),
            ),
          ),
          if (_isProcessing)
            const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CameraControls(
              onCapture: _captureImage,
              onFlashToggle: _toggleFlash,
              onCameraSwitch: _switchCamera,
              onVoiceCount: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const VoiceRecordScreen()),
              ),
              isFlashOn: _isFlashOn,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _flashAnimationController.dispose();
    super.dispose();
  }
}
