import 'package:FitVise/utilities/MLs/jump_challange_logic.dart';
import 'package:FitVise/utilities/MLs/pushup_logic.dart';
import 'package:FitVise/utilities/MLs/squat_logic.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> workoutList = [
  {
    'name': 'Push Ups',
    'description': 'A basic upper body exercise.',
    'icon': 'assets/icons/pushup.png',
    'widget': PushupLogic(),
  },
  {
    'name': 'Squats',
    'description': 'A fundamental lower body movement.',
    'icon': 'assets/icons/squat.png',
    'widget': Squatlogic(),
  },
  {
    'name': 'Body Movement Challange',
    'description':
        'Improve your body movement by moving the heart icon to the blue box',
    'icon': 'assets/icons/dance.png',
    'widget': BodyChallagelogic(),
  },
  // {
  //   'name': 'Plank',
  //   'description': 'Hold a plank position to strengthen your core muscles.',
  //   'icon': 'assets/icons/plank.png',
  //   'widget': null,
  // },
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
            leading: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.shade700,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(workout['icon'], color: Colors.white),
              ),
            ),
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
