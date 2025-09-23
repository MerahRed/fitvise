import 'package:flutter/material.dart';
import '../Pages/flexibles/infoPage.dart';

// ignore: camel_case_types
class itemCard extends StatelessWidget {
  final String cardIcon;
  final String title;
  final String description;
  // ignore: prefer_typing_uninitialized_variables
  final cardColor;
  final String exerciseImage;
  final String details;

  const itemCard({
    super.key,
    required this.cardIcon,
    required this.title,
    required this.description,
    required this.cardColor,
    required this.exerciseImage,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        ListTile(
          enabled: true,
          leading: Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: cardColor),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                cardIcon,
                color: Colors.white,
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text(description),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InfoPage(
                          exerciseName: title,
                          exerciseImage: exerciseImage,
                          exerciseDescription: details,
                          isDiet: cardColor == Colors.blue ? false : true,
                        )));
          },
          trailing: Icon(Icons.arrow_forward_ios_rounded),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          tileColor: Colors.grey,
        ),
      ],
    );
  }
}
