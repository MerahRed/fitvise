import 'package:FitVise/utilities/fun_card.dart';
import 'package:flutter/material.dart';

class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Advices'),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        padding: const EdgeInsets.all(10),
        children: [
          FunCard(
            title: 'Fun Fact',
            decoration: Icon(
              Icons.directions_walk_rounded,
              size: 150,
            ),
            subtitle:
                'Going for a walk after a meal can significantly improve blood sugar control.',
          ),
          FunCard(
            title: 'Did You Know?',
            decoration: Icon(
              Icons.water_drop_rounded,
              size: 150,
            ),
            subtitle:
                '3.7 liters (15.5 cups) daily for men and 2.7 liters (11.5 cups) daily for women',
          ),
          FunCard(
            title: 'Facts About Skin',
            decoration: Icon(
              Icons.back_hand_rounded,
              size: 150,
            ),
            subtitle:
                "The skin is the body's largest organ and is constantly shedding and replacing itself. ",
          ),
          FunCard(
            title: 'Facts About Bones',
            decoration: Icon(
              Icons.boy_rounded,
              size: 150,
            ),
            subtitle:
                "The bone mass in the skeleton makes up about 14% of the total body weight ( ca. 10–11 kg for an average person) and reaches maximum mass between the ages of 25 and 30.",
          ),
        ],
      ),
    );
  }
}
