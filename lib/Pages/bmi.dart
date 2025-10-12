import 'package:FitVise/main.dart';
import 'package:FitVise/profile_Service.dart';
import 'package:flutter/material.dart';
import 'package:FitVise/Global.dart';

class Bmipage extends StatefulWidget {
  const Bmipage({super.key});

  @override
  State<Bmipage> createState() => _BmipageState();
}

class _BmipageState extends State<Bmipage> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  double _result = 0;
  double target = 0;
  String status = "";

  double bmiTarget = 18.5;

  void calculate(TextEditingController height, TextEditingController weight) {
    setState(() {
      String height0 = height.text;
      String weight0 = weight.text;

      double? myHeight = double.tryParse(height0);
      double? myWeight = double.tryParse(weight0);

      if (myHeight != null && myWeight != null) {
        if (myHeight > 0 && myWeight > 0) {
          myHeight = myHeight / 100;
          myHeight = myHeight * myHeight;
          _result = myWeight / myHeight;

          if (_result < 18.5) {
            bmiTarget = 18.6;
          }
          if (_result > 25) {
            bmiTarget = 24.9;
          }
          target = myHeight * bmiTarget;
          targetKg = target.round();
        }
      }

      if (_result < 18.5) {
        status = "Underweight";
        exerciseIndex = 0;
        kcalIndex = 0;
      }
      if (_result >= 18.5 && _result < 25) {
        status = "Normal";
        exerciseIndex = 1;
        kcalIndex = 1;
      }
      if (_result > 25 && _result < 29.9) {
        status = "Overweight";
        exerciseIndex = 2;
        kcalIndex = 2;
      }
      if (_result > 29.9) {
        status = "Obesity";
        exerciseIndex = 3;
        kcalIndex = 3;
      }

      currentWeight = int.tryParse(weight0);
      currentHeight = int.tryParse(height0);
      userStatus = status;
      saveUserInfo(); // save result to supabase
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BMI Calculator')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //                    -TITLE-
            Center(
              child: Title(
                color: Colors.black,
                child: Text(
                  'Body Mass Index',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            //                     -GAP-
            SizedBox(height: 30),

            //                   -TEXTFIELD-
            Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height',
                  border: OutlineInputBorder(),
                  hintText: '(Cm)',
                ),
              ),
            ),

            //                      -GAP-
            SizedBox(height: 20),

            //                    -TEXTFIELD-
            Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight',
                  border: OutlineInputBorder(),
                  hintText: '(Kg)',
                ),
              ),
            ),

            //                      -GAP-
            SizedBox(height: 50),

            //                      -BUTTON-
            ElevatedButton.icon(
              icon: Icon(Icons.calculate, color: Colors.white),
              label: Text(
                'Calculate',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (_weightController.text.isNotEmpty &&
                    _heightController.text.isNotEmpty) {
                  calculate(_heightController, _weightController);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: userStatus == "Normal"
                          ? Colors.green
                          : userStatus == "Obesity"
                          ? Colors.red
                          : Colors.grey.shade700,
                      title: Center(
                        child: Text(
                          userStatus,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                      ),
                      content: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          userStatus == "Normal"
                              ? "Great! Keep it up!"
                              : userStatus == "Underweight"
                              ? "You need to gain some weight."
                              : userStatus == "Overweight"
                              ? "You need to lose some weight."
                              : "You need to lose a lot of weight.",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[200],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      actionsAlignment: MainAxisAlignment.spaceBetween,
                      actions: [
                        TextButton.icon(
                          icon: Icon(Icons.cancel, color: Colors.white),
                          label: Text(
                            'Calculate again',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton.icon(
                          icon: Icon(Icons.exit_to_app, color: Colors.white),
                          label: Text(
                            'Okay',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => MainApp(),
                              ),
                              (_) => false,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
