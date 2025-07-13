import 'dart:ffi';

import 'package:FitVise/Global.dart';
import 'package:flutter/material.dart';
import 'bmi.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  String status = '';
  int? height = 0;
  int? weight = 0;

  String message = '';

  void updatePage() {
    setState(() {
      height = currentheight;
      weight = currentweight;
      status = user_status;
    });
  }

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          Icon(
            Icons.person,
            size: 70,
            color: Colors.greenAccent,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black12, Colors.black],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(20)),
              height: 600,
              child: Column(
                children: [
                  Text(
                    'Hello!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    username,
                    style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  actions: [
                                    SizedBox(height: 30),
                                    TextField(
                                      controller: _controller,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your name...',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      message,
                                    ),
                                    SizedBox(height: 10),
                                    MaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          Navigator.of(context).pop();
                                          if (_controller.text.length < 14) {
                                            username = _controller.text;
                                            message = '';
                                          } else {
                                            message =
                                                '*username cant be more than 13 characters';
                                          }
                                        });
                                      },
                                      child: Text('done'),
                                    ),
                                  ],
                                ));
                      },
                      icon: Icon(
                        Icons.edit,
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    '-STATUS-',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    user_status,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.black12],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.height_rounded,
                              size: 60,
                            ),
                            Text('Height:'),
                            Text(currentheight.toString() + 'm')
                          ],
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.black12],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.accessibility,
                              size: 60,
                            ),
                            Text('Weight:'),
                            Text(currentweight.toString() + 'Kg')
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Divider(),
                  SizedBox(
                    height: 50,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Bmipage()),
                      );
                      updatePage(); // Trigger UI refresh after returning
                    },
                    child: Text('Edit'),
                    color: Colors.green,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
