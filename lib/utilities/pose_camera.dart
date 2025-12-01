import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class PoseCamera extends StatefulWidget {
  final Function(CameraImage image) onFrame;

  const PoseCamera({super.key, required this.onFrame});

  @override
  State<PoseCamera> createState() => _PoseCameraState();
}

class _PoseCameraState extends State<PoseCamera> {
  CameraController? _controller;

  void initState() {
    super.initState();
    initialiszeCamera();
  }

  Future<void> initialiszeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _controller!.initialize();

    _controller!.startImageStream((CameraImage image) {
      widget.onFrame(image);
    });

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return CameraPreview(_controller!);
  }
}
