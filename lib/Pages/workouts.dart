import 'package:FitVise/utilities/MLs/pushupLogic.dart';
import 'package:FitVise/utilities/MLs/squatLogic.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> workoutList = [
  {
    'name': 'Push Ups',
    'description': 'A basic upper body exercise.',
    'widget': PushupLogic(),
  },
  {
    'name': 'Squats',
    'description': 'A fundamental lower body movement.',
    'widget': Squatlogic(),
  },
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
            leading: const Icon(Icons.fitness_center),
            title: Text(workout['name'] ?? 'Unnamed Workout'),
            subtitle: Text(
              workout['description'] ?? 'No description available',
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              if (workout['widget'] != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => workout['widget']),
                );
              }
            },
          );
        }).toList(),
      ),
    );
  }
}
