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
    setState(
      () {
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

        currentweight = int.tryParse(weight0);
        currentheight = int.tryParse(height0);
        user_status = status;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.speed, size: 100, color: Colors.greenAccent),
                SizedBox(height: 10),
                //                    -TITLE-
                Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: Colors.green,
                  ),
                  child: Center(
                    child: Title(
                      color: Colors.black,
                      child: Text(
                        'Body Mass Index',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

                //                     -GAP-
                SizedBox(height: 30),

                //                    -HEIGHT-
                Text(
                  'Height: ',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),

                //                   -TEXTFIELD-
                Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: TextField(
                    controller: _heightController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '(Cm)',
                    ),
                  ),
                ),

                //                      -GAP-
                SizedBox(height: 50),

                //                     -WEIGHT-
                Text(
                  'Weight: ',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),

                //                    -TEXTFIELD-
                Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: TextField(
                    controller: _weightController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '(Kg)',
                    ),
                  ),
                ),

                //                      -GAP-
                SizedBox(height: 50),

                //                      -BUTTON-
                MaterialButton(
                  onPressed: () {
                    calculate(_heightController, _weightController);
                    //    MaterialPageRoute(builder: (context) => Homepage()));
                  },
                  color: Colors.green[700],
                  child: Text('Calculate..'),
                ),

                //                      -GAP-
                SizedBox(height: 50),

                //                   -RESULT TEXT-
                Text(
                  'Result: ',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),

                //                     -RESULT-
                Text(
                  status.toString(),
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),

                Divider(),

                Text(
                  'Details: ',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),

                Text(_result.toString(), style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
