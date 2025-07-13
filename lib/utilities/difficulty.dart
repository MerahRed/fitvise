import 'package:flutter/material.dart';
import 'package:FitVise/Global.dart';

class Difficuty extends StatelessWidget {
  final int difficultyLevel;

  const Difficuty({super.key, required this.difficultyLevel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.star,
                color: difficultyLevel >= 1 ? Colors.white : Colors.white30,
                size: 30),
            Icon(Icons.star,
                color: difficultyLevel >= 2 ? Colors.white : Colors.white30,
                size: 30),
            Icon(Icons.star,
                color: difficultyLevel >= 3 ? Colors.white : Colors.white30,
                size: 30),
            Icon(Icons.star,
                color: difficultyLevel >= 4 ? Colors.white : Colors.white30,
                size: 30),
            Icon(Icons.star,
                color: difficultyLevel == 5 ? Colors.white : Colors.white30,
                size: 30),
          ],
        ),
      ),
    );
  }
}
