import 'package:flutter/material.dart';

class FunCard extends StatelessWidget {
  final String title;
  final Widget decoration;
  final String subtitle;

  FunCard({
    super.key,
    required this.title,
    required this.decoration,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16), child: decoration),
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
