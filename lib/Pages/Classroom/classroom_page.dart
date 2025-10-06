import 'package:FitVise/Global.dart';
import 'package:FitVise/Pages/fitness.dart';
import 'package:FitVise/main.dart';
import 'package:flutter/material.dart';
import 'package:FitVise/profile_Service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

String className = "No class joined";
String teacherId = "id not assigned";
String teacherName = "No teacher assigned";
String teacherEmail = "No email assigned";
// ignore: prefer_typing_uninitialized_variables
var studentList;

//data
String announcementTitle = "No announcements yet";

class ClassroomPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
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

  /// -------------------------INITIALIZE CLASS DATA
  void initState() {
    super.initState();

    ///save when entering class page
    _loadClassDataFuture = loadClassData(widget.code);
    classCode = widget.code;
    saveUserInfo();
    loadStudents();
  }

  /// -------------------------         LOAD MEMBERS DATA
  void loadStudents() async {
    final students = await getStudentsWithSameCode(widget.code);

    setState(() {
      studentList = students;
    });
  }

  /// -------------------------             EXIT CLASS
  void exit() async {
    classCode = "";
    if (isTeacher) {
      await deleteClass(widget.code);
    } else {
      leaveClass();
    }

    await saveUserInfo();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You have left the class.")),
      );
      Navigator.pop(context);
    }
  }

  /// -------------------------             UI CLASS
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classroom'),
        centerTitle: false,
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
            onPressed: exit,
            tooltip: 'Leave Class',
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _loadClassDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error: Wrong code entered.'));
          } else {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      className,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('Class Code: ${widget.code}'),
                    const Divider(),
                    const Text(
                      'About The Teacher',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ListTile(
                      tileColor: Colors.white10,
                      leading: const Icon(Icons.person),
                      title: Text(teacherName),
                      subtitle: Text(teacherEmail),
                    ),
                    const Divider(),
                    Text(
                      'Students Enrolled: ${studentList.length}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: studentList
                          .map<Widget>(
                            (student) => ListTile(
                              tileColor: Colors.white10,
                              leading: const Icon(Icons.person),
                              title: Text(student),
                            ),
                          )
                          .toList(),
                    ),
                    Divider(), // -------------------------             ANNOUNCEMENTS
                    const Text(
                      'Announcements:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.announcement,
                                  color: Colors.white, size: 42),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      announcementTitle,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Posted on ${DateTime.now().toLocal().toString().split(' ')[0]} by $teacherName',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isTeacher)
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.white),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        String newAnnouncement =
                                            announcementTitle;
                                        return AlertDialog(
                                          title:
                                              const Text('Edit Announcement'),
                                          content: TextField(
                                            onChanged: (value) {
                                              newAnnouncement = value;
                                            },
                                            controller: TextEditingController(
                                                text: announcementTitle),
                                            decoration: const InputDecoration(
                                                hintText:
                                                    'Enter new announcement'),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                await updateAnnouncement(
                                                    widget.code,
                                                    newAnnouncement);
                                                setState(() {
                                                  announcementTitle =
                                                      newAnnouncement;
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Save'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                        // Add more announcements here
                      ],
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
