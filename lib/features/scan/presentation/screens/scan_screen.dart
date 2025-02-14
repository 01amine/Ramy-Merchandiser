import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../overview/presentation/widgets/camera_control.dart';
import '../bloc/scan/scan_bloc.dart';
import '../widgets/scan_overlay.dart';

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

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _setupAnimations();
  }

  void _initializeCamera() async {
    _controller = CameraController(
      widget.cameras[_selectedCamera],
      ResolutionPreset.high,
      enableAudio: false,
    );
    await _controller.initialize();
    // Lock orientation to portrait
    await _controller.lockCaptureOrientation(DeviceOrientation.portraitUp);
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _switchCamera() async {
    final cameraIndex = (_selectedCamera + 1) % widget.cameras.length;

    await _controller.dispose();
    setState(() {
      _selectedCamera = cameraIndex;
    });

    _initializeCamera();
  }

  Future<void> _toggleFlash() async {
    if (!_controller.value.isInitialized) return;

    try {
      if (_isFlashOn) {
        await _controller.setFlashMode(FlashMode.off);
      } else {
        await _controller.setFlashMode(FlashMode.torch);
      }

      setState(() {
        _isFlashOn = !_isFlashOn;
      });
    } catch (e) {
      // Handle error
    }
  }

  void _setupAnimations() {
    _flashAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _flashAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _flashAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  Future<void> _captureImage() async {
    if (!_controller.value.isInitialized) return;

    try {
      _flashAnimationController.forward().then((_) {
        _flashAnimationController.reverse();
      });

      // ignore: unused_local_variable
      final image = await _controller.takePicture();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // Camera Preview - Modified for portrait and full screen
          Positioned.fill(
            child: RotatedBox(
              quarterTurns: 1, // Rotate 90 degrees clockwise
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CameraPreview(_controller),
                ),
              ),
            ),
          ),

          // Scan Overlay
          const ScanOverlay(),

          // Flash Animation
          AnimatedBuilder(
            animation: _flashAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _flashAnimation.value,
                child: Container(
                  color: Colors.white,
                ),
              );
            },
          ),

          // Camera Controls (unchanged)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CameraControls(
              onCapture: _captureImage,
              onFlashToggle: _toggleFlash,
              onCameraSwitch: _switchCamera,
              onVoiceCount: () {
                context.read<ScanBloc>().add(StartVoiceCount());
              },
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
