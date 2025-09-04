import 'package:FitVise/Pages/SEGAK/pushupPage.dart';
import 'package:flutter/material.dart';

class Segakpage extends StatelessWidget {
  const Segakpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "SEGAK",
            style: TextStyle(fontWeight: FontWeight.bold),
          ), // Display exercise name
          centerTitle: true,
          backgroundColor: Colors.black87,
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    "lib/assets/bear.gif",
                    scale: 3,
                  ),
                  Text(
                    "Start measuring your body health",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => pushupPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue[300]),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Continue', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
