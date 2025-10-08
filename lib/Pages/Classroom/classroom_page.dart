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
List<Map<String, dynamic>> task = [];
var studentList;

String announcementTitle = "No announcements yet";

class ClassroomPage extends StatefulWidget {
  final code;
  const ClassroomPage({super.key, required this.code});

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

  void loadStudents() async {
    final students = await getStudentsWithSameCode(widget.code);
    setState(() {
      studentList = students;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary.withOpacity(0.2);

    return Scaffold(
      backgroundColor: Colors.grey[950],
      floatingActionButton: isTeacher
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    String newTask = '';
                    return AlertDialog(
                      backgroundColor: Colors.grey[900],
                      title: const Text('Add Task',
                          style: TextStyle(color: Colors.white)),
                      content: TextField(
                        onChanged: (value) => newTask = value,
                        decoration: const InputDecoration(
                          hintText: 'Enter task',
                          hintStyle: TextStyle(color: Colors.white54),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel',
                              style: TextStyle(color: Colors.white70)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            if (newTask.isNotEmpty) {
                              setState(() {
                                task.add({'text': newTask, 'done': false});
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
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainApp()),
              (_) => false,
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.redAccent,
            ),
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
            return const Center(
              child: Text('Error: Wrong code entered.',
                  style: TextStyle(color: Colors.redAccent)),
            );
          } else {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Class Info
                Container(
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        className,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text('Class Code: ${widget.code}',
                          style:
                              TextStyle(color: Colors.grey[400], fontSize: 13)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Teacher Info
                Text('Teacher', style: sectionTitleStyle()),
                const SizedBox(height: 8),
                cardTile(Icons.person, teacherName, teacherEmail),

                const SizedBox(height: 20),
                Divider(color: Colors.grey[700]),

                // Announcement
                Text('Announcement', style: sectionTitleStyle()),
                const SizedBox(height: 8),
                announcementCard(context),

                const SizedBox(height: 20),

                // Tasks
                Text('Tasks', style: sectionTitleStyle()),
                const SizedBox(height: 8),
                if (task.isEmpty)
                  Text('No tasks assigned yet.',
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontStyle: FontStyle.italic)),
                ...task.map<Widget>((t) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black45,
                            blurRadius: 8,
                            offset: Offset(0, 2)),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        const Icon(Icons.task, color: Colors.white),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            t['text'],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              decoration: t['done']
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                        isTeacher
                            ? IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.redAccent),
                                onPressed: () {
                                  setState(() => task.remove(t));
                                },
                              )
                            : Checkbox(
                                value: t['done'],
                                onChanged: (checked) => setState(
                                    () => t['done'] = checked ?? false),
                                activeColor: theme.colorScheme.primary,
                              ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 20),
                Divider(color: Colors.grey[700]),
                // Students
                Text('Students (${studentList.length})',
                    style: sectionTitleStyle()),
                const SizedBox(height: 8),
                ...studentList.map<Widget>(
                  (student) => cardTile(Icons.school, student, 'Student'),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget cardTile(IconData icon, String title, String subtitle) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[400])),
      ),
    );
  }

  Widget announcementCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.announcement, color: Colors.white, size: 42),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  announcementTitle,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 6),
                Text(
                  'Posted by $teacherName on ${DateTime.now().toLocal().toString().split(' ')[0]}',
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
            ),
          ),
          if (isTeacher)
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    String newAnnouncement = announcementTitle;
                    return AlertDialog(
                      backgroundColor: Colors.grey[900],
                      title: const Text('Edit Announcement',
                          style: TextStyle(color: Colors.white)),
                      content: TextField(
                        onChanged: (value) => newAnnouncement = value,
                        controller:
                            TextEditingController(text: announcementTitle),
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            hintText: 'Enter new announcement',
                            hintStyle: TextStyle(color: Colors.white54)),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel',
                              style: TextStyle(color: Colors.white70)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () async {
                            await updateAnnouncement(
                                widget.code, newAnnouncement);
                            setState(() => announcementTitle = newAnnouncement);
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
    );
  }

  TextStyle sectionTitleStyle() => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );
}
