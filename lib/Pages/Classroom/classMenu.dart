import 'package:flutter/material.dart';
import 'package:FitVise/Global.dart';
import 'package:FitVise/main.dart';

class Classmenu extends StatelessWidget {
  const Classmenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Join a Classs by entering the 6 digit code",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(200),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Class Code',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle join class action
                },
                child: Text('Join Class'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Create new Class",
          onPressed: () {},
          child: Icon(Icons.add),
        ));
  }
}
