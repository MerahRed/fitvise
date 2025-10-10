import 'package:FitVise/Global.dart';
import 'package:FitVise/main.dart';
import 'package:flutter/material.dart';
import 'package:FitVise/profile_Service.dart';

String className = "No class joined";
String teacherId = "id not assigned";
String teacherName = "No teacher assigned";
String teacherEmail = "No email assigned";
// ignore: prefer_typing_uninitialized_variables
List<Map<String, dynamic>> task = [];
var studentList;

// Data
String announcementTitle = "No announcements yet";

class ClassroomPage extends StatefulWidget {
  final String code; // class code

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
    _loadClassDataFuture = loadClassData(widget.code);
    classCode = widget.code;
    saveUserInfo();
    loadStudents();
  }

  /// ------------------------- LOAD STUDENTS
  void loadStudents() async {
    final students = await getStudentsWithSameCode(widget.code);
    setState(() {
      studentList = students;
    });
  }

  /// ------------------------- LEAVE / DELETE CLASS
  void exit() async {
    classCode = "";
    if (isTeacher) {
      await deleteClass(widget.code);
    } else {
      await leaveClass();
    }

    await saveUserInfo();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You have left the class.")),
      );
      Navigator.pop(context);
    }
  }

  /// ------------------------- UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isTeacher
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    String newTask = '';
                    return AlertDialog(
                      title: const Text('Assign Task'),
                      content: TextField(
                        onChanged: (value) {
                          newTask = value;
                        },
                        decoration:
                            const InputDecoration(hintText: 'Assign task'),
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
                            if (newTask.isNotEmpty) {
                              setState(() {
                                task.add({'name': newTask, 'completed': false});
                                saveTasks(widget.code, task);
                              });
                            }
                            Navigator.of(context).pop();
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              },
              tooltip: 'Assign Task',
              child: const Icon(Icons.add),
            )
          : null,
      appBar: AppBar(
        title: const Text('Classroom'),
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
                /// ------------------------- CLASS HEADER
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///  ------------------------------ DBUGGER
                    Text(task.toString()),

                    ///
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.indigo.shade700,
                            radius: 28,
                            child: const Icon(Icons.person,
                                size: 32, color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            teacherName,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            teacherEmail,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Text(
                      'Students Enrolled: ${studentList != null ? studentList.length : 0}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: studentList != null
                            ? studentList
                                .map<Widget>(
                                  (student) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.blue[500],
                                          radius: 24,
                                          child: const Icon(Icons.person,
                                              size: 28, color: Colors.white),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          student,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList()
                            : [],
                      ),
                    ),
                  ],
                ),
                const Divider(),

                /// ------------------------- ANNOUNCEMENT SECTION
                const Text(
                  'Announcements:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _announcementCard(),

                /// ------------------------- TASK SECTION
                const SizedBox(height: 8),
                ...task.map<Widget>((t) => _taskCard(context, t)), // Task cards
              ],
            );
          }
        },
      ),
    );
  }

  /// ------------------------- ANNOUNCEMENT CARD WIDGET
  Widget _announcementCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade700, Colors.indigo.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.15),
            ),
            padding: const EdgeInsets.all(10),
            child:
                const Icon(Icons.announcement, size: 38, color: Colors.white),
          ),
          const SizedBox(width: 16),
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
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.person, size: 14, color: Colors.white70),
                    const SizedBox(width: 4),
                    Text(
                      teacherName,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.calendar_today,
                        size: 14, color: Colors.white70),
                    const SizedBox(width: 4),
                    Text(
                      'Posted on ${DateTime.now().toLocal().toString().split(' ')[0]}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isTeacher)
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      String newAnnouncement = announcementTitle;
                      return AlertDialog(
                        title: const Text('Edit Announcement'),
                        content: TextField(
                          onChanged: (value) {
                            newAnnouncement = value;
                          },
                          controller:
                              TextEditingController(text: announcementTitle),
                          decoration: const InputDecoration(
                            hintText: 'Enter new announcement',
                          ),
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
                                  widget.code, newAnnouncement);
                              if (mounted) {
                                setState(() {
                                  announcementTitle = newAnnouncement;
                                });
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  /// ------------------------- TASK CARD WIDGET
  Widget _taskCard(BuildContext context, t) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.grey.shade900,
      ),
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.task, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t['name'].toString(),
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                    // decoration: t['completed']
                    //     ? TextDecoration.lineThrough
                    //     : TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 13, color: Colors.white70),
                    const SizedBox(width: 4),
                    Text(
                      'Assigned on ${DateTime.now().toLocal().toString().split(' ')[0]}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8),
            child: isTeacher
                ? IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    tooltip: 'Delete Task',
                    onPressed: () async {
                      setState(() {
                        task.remove(t);
                        saveTasks(widget.code, task);
                      });
                    },
                  )
                : Checkbox(
                    value: t['completed'] ?? false,
                    onChanged: (checked) {
                      setState(() {
                        t['completed'] = !t['completed'];
                      });
                    },
                    activeColor: Colors.indigo,
                    checkColor: Colors.white,
                  ),
          )
        ],
      ),
    );
  }
}
