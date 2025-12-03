import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:FitVise/utilities/pose_camera.dart';

class PushupLogic extends StatefulWidget {
  const PushupLogic({super.key});

  @override
  State<PushupLogic> createState() => _PushupLogicState();
}

class _PushupLogicState extends State<PushupLogic> {
  late CameraController _cameraController;

  final poseDetector = PoseDetector(
    options: PoseDetectorOptions(
      mode: PoseDetectionMode.stream,
      model: PoseDetectionModel.base, // BASE MODEL = FAST AND SUPPORTED
    ),
  );

  // Use NOTIFIERS instead of setState (MUCH FASTER)
  final lengthValue = ValueNotifier<int>(0);
  final pointsValue = ValueNotifier<int>(0);
  final boxY = ValueNotifier<double>(50);
  final goText = ValueNotifier<String>('Go Down');
  final goingDownValue = ValueNotifier<bool>(true);

  final test = ValueNotifier<double>(0);

  bool _isBusy = false; // throttle ML
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
      ResolutionPreset.low, // ↓ LOWER = HUGE SPEED BOOST
      enableAudio: false,
    );

    await _cameraController.initialize();
    _cameraController.startImageStream(processCameraImage);
  }

  // ------------------------------ PROCESS FRAME ------------------------------

  void processCameraImage(CameraImage image) async {
    if (_isBusy) return;
    _isBusy = true;

    final inputImage = _convertToInputImage(image);
    final result = await poseDetector.processImage(inputImage);

    if (result.isNotEmpty) {
      final pose = result.first;
      lastPose = pose;

      final wrist = pose.landmarks[PoseLandmarkType.leftWrist];
      final shoulder = pose.landmarks[PoseLandmarkType.leftShoulder];
      final nose = pose.landmarks[PoseLandmarkType.nose];

      test.value = wrist!.y;

      if (shoulder != null && nose != null) {
        final length = (wrist.y - shoulder.y).abs().toInt();
        lengthValue.value = length;

        // PUSHUP LOGIC
        if (wrist.y > 300) {
          if (length < 50 && nose.y > 200) {
            boxY.value = 50;
            goText.value = "Go Up";
            goingDownValue.value = true;
          }
          if (goingDownValue.value == true && length > 200 && nose.y < 150) {
            pointsValue.value++;
            boxY.value = 600;
            goText.value = "Go Down";
            goingDownValue.value = false;
          }
        } else {
          goText.value = "Place your hand on the ground";
        }
      }
    }

    _isBusy = false;
  }

  // ------------------------------ CONVERT IMAGE ------------------------------

  InputImage _convertToInputImage(CameraImage image) {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
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

  // ------------------------------ BUILD UI ------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Push Up"),
        actions: [
          IconButton(
            onPressed: () => pointsValue.value = 0,
            icon: Icon(Icons.restore_page_outlined),
          ),
        ],
      ),
      body: Stack(
        children: [
          // CAMERA PREVIEW
          Positioned.fill(child: PoseCamera(onFrame: processCameraImage)),

          // GUIDENCE
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

          // GOING DOWN DISPLAY
          ValueListenableBuilder(
            valueListenable: boxY,
            builder: (_, y, _) {
              return Positioned(
                top: y,
                right: 450,
                child: _infoBox("Move Here", Colors.blue, 32),
              );
            },
          ),

          // PUSHUP COUNT
          Positioned(
            top: 100,
            right: 16,
            child: ValueListenableBuilder(
              valueListenable: pointsValue,
              builder: (context, points, _) {
                return _infoBox('Reps: $points', Colors.red, 18);
              },
            ),
          ),
          Positioned(
            top: 200,
            right: 16,
            child: ValueListenableBuilder(
              valueListenable: test,
              builder: (_, txt, _) {
                return _infoBox('pos y wrist: $txt', Colors.red, 18);
              },
            ),
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
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
