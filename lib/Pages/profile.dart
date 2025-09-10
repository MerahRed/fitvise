import 'package:FitVise/Global.dart';
import 'package:FitVise/auth/auth_service.dart';
import 'package:FitVise/profile_Service.dart';
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
            child: Column(
              children: [
                Text(
                  currentUsername,
                  style: TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                Text(
                  currentEmail,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  status,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 50,
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
                          Text('${currentheight}m')
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
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: MaterialButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Bmipage()),
                      );
                      updatePage(); // Trigger UI refresh after returning
                    },
                    color: Colors.green,
                    child: Text('Edit'),
                  ),
                )
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.contact_mail),
                    title: Text('Contact Us'),
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
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Are you sure?",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(height: 30),
                                        Row(
                                          children: [
                                            MaterialButton(
                                              onPressed: () {
                                                setState(() {
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                              child: Text('Cancel'),
                                            ),
                                            SizedBox(width: 10),
                                            MaterialButton(
                                              textColor: Colors.red,
                                              onPressed: () {
                                                setState(() {
                                                  logout();
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                              child: Text('Log Out'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ));
                    },
                  ),
                  ListTile(
                    title: Text('Developed by MerahRed'),
                    subtitle: Text('Version 1.0.0'),
                    trailing: Icon(Icons.info_outline),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
