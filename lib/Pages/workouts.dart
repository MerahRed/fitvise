import 'package:FitVise/Pages/flexibles/workoutDetails.dart';
import 'package:FitVise/utilities/pose_camera.dart';
import 'package:flutter/material.dart';

final List<Map<String, String>> workoutList = [
  {'name': 'Push Ups', 'description': 'A basic upper body exercise.'},
  {'name': 'Squats', 'description': 'A fundamental lower body movement.'},
];

class Workouts extends StatelessWidget {
  const Workouts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Workouts',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: workoutList.map((workout) {
          return ListTile(
            title: Text(workout['name'] ?? 'Unnamed Workout'),
            subtitle: Text(
              workout['description'] ?? 'No description available',
            ),
            leading: Icon(Icons.fitness_center),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => // Workoutdetails(
                          //   workoutName: workout['name'] ?? 'Workout',
                          //   description: workout['description'] ?? 'no item',
                          // ),
                          Workoutdetails(),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
