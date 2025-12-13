import 'package:FitVise/Pages/Classroom/classroom_page.dart';
import 'package:FitVise/Pages/Classroom/create_class_popup.dart';
import 'package:FitVise/utilities/premium_popup.dart';
import 'package:flutter/material.dart';
import 'package:FitVise/Global.dart';

class Classmenu extends StatelessWidget {
  Classmenu({super.key});

  final _controller = TextEditingController();

  void joinClass() {
    classCode = _controller.text;
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isTablet = media.size.shortestSide >= 600;
    final padding = isTablet ? 48.0 : 16.0;
    final textFieldWidth = isTablet ? 400.0 : double.infinity;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Join a Class by entering the 6 digit code",
                  style: TextStyle(fontSize: isTablet ? 28 : 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isTablet ? 32 : 16),
                SizedBox(
                  width: textFieldWidth,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Class Code',
                    ),
                  ),
                ),
                SizedBox(height: isTablet ? 32 : 16),
                SizedBox(
                  width: textFieldWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ClassroomPage(code: _controller.text),
                        ),
                      );
                    },
                    child: Text(
                      'Join Class',
                      style: TextStyle(fontSize: isTablet ? 22 : 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
      ),
    );
  }
}
