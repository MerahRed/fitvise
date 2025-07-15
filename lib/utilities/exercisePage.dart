import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:FitVise/Global.dart';
import 'difficulty.dart';

class ExercisePage extends StatefulWidget {
  final String exerciseName;
  final String exerciseImage;
  final String exerciseDescription;
  final bool isExercise;
  const ExercisePage({
    super.key,
    required this.exerciseName,
    required this.exerciseImage,
    required this.exerciseDescription,
    required this.isExercise,
  });

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.exerciseName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ), // Display exercise name
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Image.asset(
              widget.exerciseImage,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              widget.exerciseName,
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(widget.exerciseDescription,
                style: TextStyle(
                  fontSize: 20,
                )),
            SizedBox(height: 20),
            Divider(),
            widget.isExercise == true
                ? Column(
                    children: [
                      Text("Exercise Difficuty",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          )),
                      Difficuty(difficultyLevel: 2),
                      SizedBox(height: 100),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(
                              context); // Navigate back to the previous screen
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          padding: EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15,
                          ),
                          textStyle: TextStyle(fontSize: 20),
                        ),
                        child: Icon(Icons.check_rounded,
                            size: 40, color: Colors.white),
                      ),
                    ],
                  )
                : Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Target Kcal",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          //              WELCOME TO SPAGGHETTI CODE HELL  >:) (forgive me my future self;-;)
                          user_status == 'Underweight'
                              ? widget.exerciseName == 'Breakfast'
                                  ? "700"
                                  : widget.exerciseName == 'Snack'
                                      ? "500"
                                      : widget.exerciseName == 'Lunch'
                                          ? "800"
                                          : widget.exerciseName == 'Dinner'
                                              ? "800"
                                              : "null"
                              : user_status == 'Normal'
                                  ? widget.exerciseName == 'Breakfast'
                                      ? "500"
                                      : widget.exerciseName == 'Snack'
                                          ? "400"
                                          : widget.exerciseName == 'Lunch'
                                              ? "600"
                                              : widget.exerciseName == 'Dinner'
                                                  ? "600"
                                                  : "null"
                                  : user_status == 'Overweight'
                                      ? widget.exerciseName == 'Breakfast'
                                          ? "400"
                                          : widget.exerciseName == 'Snack'
                                              ? "300"
                                              : widget.exerciseName == 'Lunch'
                                                  ? "600"
                                                  : widget.exerciseName ==
                                                          'Dinner'
                                                      ? "450"
                                                      : "null"
                                      : user_status == 'Obesity'
                                          ? widget.exerciseName == 'Breakfast'
                                              ? "300"
                                              : widget.exerciseName == 'Snack'
                                                  ? "150"
                                                  : widget.exerciseName ==
                                                          'Lunch'
                                                      ? "500"
                                                      : widget.exerciseName ==
                                                              'Dinner'
                                                          ? "400"
                                                          : "null"
                                          : "null",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
