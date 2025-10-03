import 'package:FitVise/Global.dart';
import 'package:FitVise/Pages/fitness.dart';
import 'package:FitVise/main.dart';
import 'package:flutter/material.dart';
import 'package:FitVise/profile_Service.dart';

String className = "No class joined";
String teacherId = "id not assigned";
String teacherName = "No teacher assigned";
String teacherEmail = "No email assigned";

class ClassroomPage extends StatefulWidget {
  final code; // placeholder for class ID

  const ClassroomPage({
    super.key,
    required this.code,
  });

  @override
  State<ClassroomPage> createState() => _ClassroomPageState();
}

class _ClassroomPageState extends State<ClassroomPage> {
  late Future<void> _loadClassDataFuture;

  @override
  void initState() {
    super.initState();

    ///save when entering class page
    _loadClassDataFuture = loadClassData(widget.code);
    saveUserInfo();
  }

  void leaveClass() async {
    // Implement leave class logic here
    // For example, you might want to clear the classCode and related info
    classCode = "";

    await saveUserInfo();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You have left the class.")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classroom'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainApp()),
                (_) => false);
          },
          tooltip: 'Back',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: leaveClass,
            tooltip: 'Leave Class',
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _loadClassDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: Wrong code entered.'));
          } else {
            return ListView(
              children: [
                Center(
                  child: Column(
                    children: [
                      Text('Welcome to the Classroom Page!'),
                      Text('Class Name: $className'),
                      Text('Class Code: ${widget.code}'),
                      Divider(),
                      Text('Teacher: $teacherId'),
                      Text('Teacher Name: $teacherName'),
                      Text('Teacher Email: $teacherEmail'),
                      Divider(),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _loadClassDataFuture = loadClassData(widget.code);
                          });
                        },
                        child: Text('Data refresh'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
