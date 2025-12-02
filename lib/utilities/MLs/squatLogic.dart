import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import 'package:FitVise/utilities/pose_camera.dart';

class Squatlogic extends StatefulWidget {
  const Squatlogic({super.key});

  @override
  State<Squatlogic> createState() => _SquatlogicState();
}

class _SquatlogicState extends State<Squatlogic> {
  late CameraController _cameraController;
  final poseDetector = PoseDetector(
    options: PoseDetectorOptions(mode: PoseDetectionMode.stream),
  );

  List poses = [];

  //Extra variables for workout logic
  String testing = "no results";
  String go = "Go Up";
  Pose? lastPose;

  int points = 0;
  bool goingDown = false;

  double boxPositionY = 100; //500

  // ------------------ML Kit Pose Detection and Camera Setup------------------

  // Initialize camera and start image stream
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

    //  -------------------------- Run pose detection --------------------------

    final result = await poseDetector.processImage(inputImage);

    // Nose detection for Squat
    PoseLandmark? nose;
    if (result.isNotEmpty) {
      nose = result.first.landmarks[PoseLandmarkType.nose];
    }

    testing = nose != null
        ? 'Nose Position: (${nose.x.toStringAsFixed(0)}, ${nose.y.toStringAsFixed(0)})'
        : 'No Body not detected';

    if (nose!.y < 150) {
      go = 'Go Down';
      goingDown = true;
      boxPositionY = 500;
    }
    if (nose.y > 300) {
      go = 'Go Up';
      boxPositionY = 100;
    }
    if (goingDown == true && nose.y > 300) {
      points += 1;
      goingDown = false;
    }

    // ------------------------------ update UI ------------------------------

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

  // ------------------------------ Build UI ------------------------------

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
                          "Reps: $points",
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
                /*
                Positioned(
                  top: 16,
                  right: 700,
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
                ),*/
                Positioned(
                  top: boxPositionY,
                  right: 350,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Text(
                            'Move Here',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
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
