import 'package:FitVise/utilities/diet_table.dart';
import 'package:flutter/material.dart';
import 'package:FitVise/Global.dart';

class InfoPage extends StatefulWidget {
  final String exerciseName;
  final String exerciseImage;
  final String exerciseDescription;
  final bool isDiet;
  const InfoPage({
    super.key,
    required this.exerciseName,
    required this.exerciseImage,
    required this.exerciseDescription,
    required this.isDiet,
  });

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late final int target;

  @override
  void initState() {
    super.initState();
    target = getTargetCalories(userStatus, widget.exerciseName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     widget.exerciseName,
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ), // Display exercise name
      //   centerTitle: true,
      //   backgroundColor: Colors.black87,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    if (widget.exerciseImage.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          widget.exerciseImage,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          scale: 2,
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.exerciseName,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 20),
                    Text(
                      widget.exerciseDescription,
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 20),
                    widget.isDiet ==
                            true // check if it's diet page
                        ? Column(
                            children: [
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Text(
                                    '${widget.exerciseName} Suggestion',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: DietTable(mealType: widget.exerciseName),
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Target Kcal",
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    Text(
                                      '$target',
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(30),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black12,
                                    minimumSize: Size(double.infinity, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Close',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.all(30),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black12,
                                minimumSize: Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Close',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*
          MaterialButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InfoPage(
                          exerciseName: "s",
                          exerciseImage: 'lib/assets/walking.jpeg',
                          exerciseDescription: 'exerciseDescription',
                          isDiet: false,
                        )),
              );
            },
            color: Colors.green,
            child: Text('Edit'),
          ),

*/