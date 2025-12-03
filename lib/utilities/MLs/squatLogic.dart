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
    options: PoseDetectorOptions(
      mode: PoseDetectionMode.stream,
      model: PoseDetectionModel.base, // SPEED BOOST
    ),
  );

  // Use ValueNotifier for performance
  final pointsValue = ValueNotifier<int>(0);
  final goText = ValueNotifier<String>("Go Up");
  final boxY = ValueNotifier<double>(100);

  bool goingDown = false;
  bool _isBusy = false;
  Pose? lastPose;

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
      ResolutionPreset.low, // huge boost
      enableAudio: false,
    );

    await _cameraController.initialize();
    _cameraController.startImageStream(processCameraImage);
  }

  // --------------------------- PROCESS FRAME ---------------------------

  void processCameraImage(CameraImage image) async {
    if (_isBusy) return;
    _isBusy = true;

    final inputImage = _convertToInputImage(image);
    final result = await poseDetector.processImage(inputImage);

    if (result.isNotEmpty) {
      final pose = result.first;
      lastPose = pose;

      final nose = pose.landmarks[PoseLandmarkType.nose];
      final leftKnee = pose.landmarks[PoseLandmarkType.leftKnee];

      if (nose != null) {
        if (leftKnee!.y > 300 && leftKnee.y < 800) {
          final y = nose.y;

          if (y < 150) {
            goText.value = "Go Down";
            goingDown = true;
            boxY.value = 500;
          }

          if (y > 300) {
            goText.value = "Go Up";
            boxY.value = 100;
          }

          if (goingDown == true && y > 300) {
            pointsValue.value++;
            goingDown = false;
          }
        } else {
          goText.value = "Make sure your full body is on Camera";
        }
      }
    }

    _isBusy = false;
  }

  // --------------------------- IMAGE CONVERSION ---------------------------

  InputImage _convertToInputImage(CameraImage image) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize = Size(
      image.width.toDouble(),
      image.height.toDouble(),
    );

    final camera = _cameraController.description;
    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
        InputImageRotation.rotation0deg;

    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw) ??
        InputImageFormat.nv21;

    final planeData = image.planes
        .map(
          (Plane plane) => InputImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          ),
        )
        .toList();

    return InputImage.fromBytes(
      bytes: bytes,
      inputImageData: InputImageData(
        size: imageSize,
        imageRotation: imageRotation,
        inputImageFormat: inputImageFormat,
        planeData: planeData,
      ),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    poseDetector.close();
    super.dispose();
  }

  // --------------------------- BUILD UI ---------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Squat"),
        actions: [
          IconButton(
            onPressed: () => pointsValue.value = 0,
            icon: Icon(Icons.restore_page_outlined),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(child: PoseCamera(onFrame: processCameraImage)),

          // REPS
          Positioned(
            top: 16,
            right: 16,
            child: ValueListenableBuilder(
              valueListenable: pointsValue,
              builder: (_, points, __) {
                return _infoBox("Reps: $points", Colors.red, 25);
              },
            ),
          ),

          // GO UP / GO DOWN
          Positioned(
            top: 16,
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150),
                child: ValueListenableBuilder(
                  valueListenable: goText,
                  builder: (_, txt, __) {
                    return _infoBox(txt, Colors.green, 36);
                  },
                ),
              ),
            ),
          ),

          // MOVE HERE BOX
          ValueListenableBuilder(
            valueListenable: boxY,
            builder: (_, y, __) {
              return Positioned(
                top: y,
                right: 450,
                child: Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Move Here",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _infoBox(String text, Color color, double fontSize) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
