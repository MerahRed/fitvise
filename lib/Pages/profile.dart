import 'package:FitVise/Global.dart';
import 'package:FitVise/Pages/flexibles/infoPage.dart';
import 'package:FitVise/auth/auth_service.dart';
import 'package:FitVise/profile_Service.dart';
import 'package:flutter/material.dart';

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
      height = currentHeight;
      weight = currentWeight;
      status = userStatus;
    });
  }

  final authService = AuthService();
  //log out
  void logout() async {
    await authService.signOut();
  }

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await loadUserInfo();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  currentUsername,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  currentEmail,
                  style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                ),
                Icon(
                  Icons.accessibility_new_rounded,
                  size: 300,
                  color: userStatus == "Normal"
                        ? Colors.green
                        : userStatus == "Obesity"
                            ? Colors.red
                            : Colors.grey,
                ),
                Text(
                  '-$userStatus-',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: userStatus == "Normal"
                        ? Colors.green
                        : userStatus == "Obesity"
                            ? Colors.red
                            : Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //    height
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white10,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Icon(
                              Icons.height,
                              size: 100,
                            ),
                            SizedBox(width: 10),
                            Column(
                              children: [
                                Text(
                                  "Height",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "$currentHeight cm",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    //        mass
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white10,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Icon(
                              Icons.speed,
                              size: 100,
                            ),
                            SizedBox(width: 10),
                            Column(
                              children: [
                                Text(
                                  "Weight",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "$currentWeight kg",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Divider(
            indent: 20,
            endIndent: 20,
            color: Colors.white24,
            thickness: 1,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.contact_mail),
                    title: Text('Contact Us'),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InfoPage(
                                exerciseName: "Contact Us",
                                exerciseImage: "",
                                exerciseDescription:
                                    "Contact us at Innovvice5001@gmail.com",
                                isDiet: false),
                          ),
                          (_) => false);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person_2),
                    title: Row(
                      children: [
                        Text('Apply Teacher Account'),
                        if (!isTeacher)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.stars_rounded,
                              color: Colors.greenAccent,
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Log Out'),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.grey.shade700,
                          title: Row(
                            children: [
                              Icon(Icons.logout,
                                  color: Colors.redAccent, size: 28),
                              SizedBox(width: 10),
                              Text(
                                "Log Out",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                          content: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Are you sure you want to log out?",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          actionsAlignment: MainAxisAlignment.spaceBetween,
                          actions: [
                            TextButton.icon(
                              icon: Icon(Icons.cancel, color: Colors.white),
                              label: Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton.icon(
                              icon:
                                  Icon(Icons.exit_to_app, color: Colors.white),
                              label: Text(
                                'Log Out',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                logout();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Developed by MerahRed'),
                    subtitle: Text('Version 1.0.0'),
                    leading: Icon(Icons.info_outline),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
