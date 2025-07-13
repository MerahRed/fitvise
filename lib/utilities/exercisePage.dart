import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:FitVise/Global.dart';
import 'difficulty.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("lib/assets/qamariah.mp4")
      ..initialize().then((_) {
        setState(() {}); // Rebuild to show video
        _controller.play(); // Start playing
        //_controller.setLooping(true); // Loop the video
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          exercise[exerciseIndex][0][0],
          style: TextStyle(fontWeight: FontWeight.bold),
        ), // Display exercise name
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : const CircularProgressIndicator(), // Show loading indicator instead of plain text
            ),
            SizedBox(height: 20),
            Text(
              exercise[exerciseIndex][0][0],
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            Text(exercise[exerciseIndex][0][3],
                style: TextStyle(
                  fontSize: 20,
                )),
            Divider(),
            Text("Exercise Difficuty",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
            Difficuty(difficultyLevel: 2),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
