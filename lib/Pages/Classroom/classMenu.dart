import 'package:FitVise/Pages/Classroom/classroom_page.dart';
import 'package:FitVise/Pages/Classroom/create_class_popup.dart';
import 'package:FitVise/utilities/premium_popup.dart';
import 'package:flutter/material.dart';
import 'package:FitVise/Global.dart';

class Classmenu extends StatelessWidget {
  Classmenu({super.key});

  final _controller = TextEditingController();

  void joinClass() {
    // Implement join class logic here
    classCode = _controller.text;
  }

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
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Class Code',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle join class
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ClassroomPage(code: _controller.text),
                    ),
                  );
                },
                child: Text('Join Class'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Create new Class",
          onPressed: () {
            if (!isPremium) {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const PremiumPopup(),
                  );
                },
              );
            } else {
              if (!isTeacher) {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Text('Please apply for Teacher Account'),
                    );
                  },
                );
              } else {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: CreateClassPopup(),
                    );
                  },
                );
              }
            }
          },
          child: Icon(Icons.add),
        ));
  }
}
