import 'package:FitVise/Global.dart';
import 'package:FitVise/Pages/Classroom/classroom_page.dart';
import 'package:flutter/material.dart';
import 'package:FitVise/profile_Service.dart';
import 'dart:math';

class CreateClassPopup extends StatelessWidget {
  CreateClassPopup({super.key});

  final _controller = TextEditingController();
  String code = '';

  void createCode() {
    final Random random = Random();
    int randomNumber = 100000 + random.nextInt(900000);
    code = randomNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white10, width: 1),
        borderRadius: BorderRadius.circular(24),
        color: Colors.grey.shade900,
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close_rounded),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Create a class',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 40, bottom: 40, left: 80, right: 80),
                child: Column(
                  children: [
                    TextField(
                      controller: _controller,
                      maxLength: 20,
                      decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Text(
                      'Everyone will know your class with this name',
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  createCode();
                  createClass(_controller.text, code);
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //   content:
                  //       Text("${_controller.text} created with code $code"),
                  // ));
                  classCode = code;
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ClassroomPage(code: code);
                    },
                  ));
                },
                child: Text('Create Class'),
              )
            ],
          )
        ],
      ),
    );
  }
}
