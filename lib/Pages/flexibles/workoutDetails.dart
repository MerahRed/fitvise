import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import 'package:FitVise/utilities/pose_camera.dart';

class Workoutdetails extends StatefulWidget {
  const Workoutdetails({super.key});

  @override
  State<Workoutdetails> createState() => _WorkoutdetailsState();
}

class _WorkoutdetailsState extends State<Workoutdetails> {
  late CameraController _cameraController;
  final poseDetector = PoseDetector(
    options: PoseDetectorOptions(mode: PoseDetectionMode.stream),
  );

  List poses = [];
  String testing = "no results";
  String go = "Go Up";
  Pose? lastPose;

  int points = 0;
  bool goingDown = false;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    _cameraController = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _cameraController.initialize();
    _cameraController.startImageStream(processCameraImage);
  }

  void processCameraImage(CameraImage image) async {
    // Convert camera image for ML Kit
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }

    final bytes = allBytes.done().buffer.asUint8List();
    final Size size = Size(image.width.toDouble(), image.height.toDouble());

    final imageRotation =
        InputImageRotationValue.fromRawValue(
          _cameraController.description.sensorOrientation,
        ) ??
        InputImageRotation.rotation0deg;

    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw) ??
        InputImageFormat.nv21;

    final planeData = image.planes
        .map(
          (plane) => InputImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          ),
        )
        .toList();

    final inputImage = InputImage.fromBytes(
      bytes: bytes,
      inputImageData: InputImageData(
        size: size,
        imageRotation: imageRotation,
        inputImageFormat: inputImageFormat,
        planeData: planeData,
      ),
    );

    // Run pose detection
    final result = await poseDetector.processImage(inputImage);

    PoseLandmark? rightWrist;
    if (result.isNotEmpty) {
      rightWrist = result.first.landmarks[PoseLandmarkType.rightWrist];
    }

    testing = rightWrist != null
        ? 'Right Wrist: (${rightWrist.x.toStringAsFixed(0)}, ${rightWrist.y.toStringAsFixed(0)})'
        : 'Right Wrist not detected';

    if (rightWrist!.y < 100) {
      go = 'Go Down';
      goingDown = true;
    }
    if (rightWrist!.y > 400) {
      go = 'Go Up';
    }
    if (goingDown == true && rightWrist!.y > 400) {
      points += 1;
      goingDown = false;
    }

    // Safely update UI
    if (mounted) {
      setState(() {
        poses = result;
        lastPose = poses.isNotEmpty ? poses.first : null;
      });
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    poseDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout Details"),
        actions: [
          IconButton(
            onPressed: () {
              points = 0;
            },
            icon: Icon(Icons.restore_page_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PoseCamera(onFrame: processCameraImage),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Points: $points",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 400,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          go,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 750,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          testing,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
