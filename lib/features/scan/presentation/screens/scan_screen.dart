import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import '../../../overview/presentation/widgets/camera_control.dart';

class ScanScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Function(String imagePath)? onImageCaptured;
  final bool enableAudio;
  final FlashMode initialFlashMode;

  const ScanScreen({
    super.key,
    required this.cameras,
    this.onImageCaptured,
    this.enableAudio = false,
    this.initialFlashMode = FlashMode.off,
  });

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
        enableAudio: widget.enableAudio,
      );
      await _controller.initialize();
      await _controller.lockCaptureOrientation(DeviceOrientation.portraitUp);
      await _controller.setFlashMode(widget.initialFlashMode);
      setState(() => _isFlashOn = widget.initialFlashMode == FlashMode.torch);
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
      await _controller.setFlashMode(_isFlashOn ? FlashMode.off : FlashMode.torch);
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
      _flashAnimationController.forward().then((_) => _flashAnimationController.reverse());
      final image = await _controller.takePicture();
      setState(() => _isProcessing = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _isProcessing = false);
      widget.onImageCaptured?.call(image.path);
    } catch (e) {
      debugPrint("Error capturing image: $e");
    }
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
            const Center(child: CircularProgressIndicator(color: Colors.white)),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CameraControls(
              onCapture: _captureImage,
              onFlashToggle: _toggleFlash,
              onCameraSwitch: _switchCamera,
              onVoiceCount: _onVoiceCount,
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
