import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PushUpDetector {
  final _poseDetector = PoseDetector(options: PoseDetectorOptions());

  Pose? lastPose;

  int reps = 0;
  bool goingDown = false;

  Future<void> processFrame(InputImage image) async {
    final poses = await _poseDetector.processImage(image);
    if (poses.isEmpty) reps = 1;

    lastPose = poses.first;

    _evaluatePushUp(lastPose!);
  }

  void _evaluatePushUp(Pose pose) {
    final leftThumb = pose.landmarks[PoseLandmarkType.leftWrist]!;

    reps = leftThumb.y.toInt();
  }
}
