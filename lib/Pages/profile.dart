import 'package:FitVise/Global.dart';
import 'package:FitVise/Pages/flexibles/info_page.dart';
import 'package:FitVise/auth/auth_service.dart';
import 'package:FitVise/profile_Service.dart';
import 'package:FitVise/utilities/premium_popup.dart';
import 'package:flutter/material.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  final authService = AuthService();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await loadUserInfo();
    setState(() => loading = false);
  }

  void logout() async {
    await authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                //  --------------------------------------------------Profile Header
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade900, Colors.blueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 60, color: Colors.blue),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentUsername,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          isPremium
                              ? Icon(
                                  Icons.workspace_premium,
                                  color: Colors.tealAccent,
                                )
                              : SizedBox(),
                        ],
                      ),
                      Text(
                        currentEmail,
                        style: TextStyle(fontSize: 16, color: Colors.white38),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 14,
                        ),
                        decoration: BoxDecoration(
                          color: userStatus == "Normal"
                              ? Colors.blue.shade700
                              : userStatus == "Obesity"
                              ? Colors.red.shade700
                              : Colors.grey.shade600,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          userStatus,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ---------------------------------------------------- Stats
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: _statCard(
                          "Height",
                          "$currentHeight cm",
                          Icons.height,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _statCard(
                          "Weight",
                          "$currentWeight kg",
                          Icons.monitor_weight,
                          Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _statCard(
                          "BMI",
                          ((currentWeight! /
                                  ((currentHeight! / 100) *
                                      (currentHeight! / 100)))
                              .toStringAsFixed(1)),
                          Icons.favorite,
                          Colors.pink,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // ----------------------------------------------------  Options
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      _profileTile(
                        icon: Icons.contact_mail,
                        title: "Contact Us",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InfoPage(
                                exerciseName: "Contact Us",
                                exerciseImage: "",
                                exerciseDescription:
                                    "Contact us at Innovvice5001@gmail.com",
                                isDiet: false,
                              ),
                            ),
                          );
                        },
                      ),
                      _profileTile(
                        icon: Icons.person_2,
                        title: "Apply Teacher Account",
                        trailing: !isTeacher
                            ? const Icon(
                                Icons.workspace_premium,
                                color: Colors.cyanAccent,
                              )
                            : const Icon(Icons.check, color: Colors.cyanAccent),
                        onTap: () {
                          if (isPremium == false) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: const EdgeInsets.all(16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: const PremiumPopup(),
                                );
                              },
                            );
                          } else {
                            setState(() {
                              isTeacher = !isTeacher;
                              saveUserInfo();
                            });
                          }
                        },
                      ),
                      // -------------------------- DeBugging Tools
                      _profileTile(
                        icon: Icons.handyman_rounded,
                        title: "Im the Developer",
                        color: Colors.grey,
                        trailing: isPremium
                            ? const Icon(Icons.check_box_outlined)
                            : const Icon(
                                Icons.check_box_outline_blank_outlined,
                              ),
                        onTap: () {
                          final passcode = TextEditingController();
                          if (!isPremium) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Prove Yourself'),
                                  content: TextField(
                                    onChanged: (value) {
                                      passcode.text = value;
                                    },
                                    controller: passcode,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter passcode..',
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
                                        if (passcode.text == "innovvice") {
                                          setState(() {
                                            isPremium = true;

                                            saveUserInfo();
                                          });
                                          // Passcode
                                        }
                                        Navigator.pop(context);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                isPremium
                                                    ? "Welcome Developer!"
                                                    : 'Wrong Passcode',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    isPremium
                                                        ? "Start Developing!"
                                                        : 'Close',
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Text('Save'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            setState(() {
                              isPremium = false;
                              isTeacher = false;
                              saveUserInfo();
                            });
                          }
                        },
                      ),
                      _profileTile(
                        icon: Icons.logout,
                        title: "Log Out",
                        color: Colors.redAccent,
                        onTap: () {
                          _confirmLogout(context);
                        },
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Developed by MerahRed\nVersion 1.8.0",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // -----------------------------------------------------------------  stat card
  Widget _statCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 40),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------  profile tile
  Widget _profileTile({
    required IconData icon,
    required String title,
    Color? color,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: color ?? Colors.blue),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  // ---------------------------------------------------- log out dialogbox
  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.grey.shade800,
        title: const Text("Log Out", style: TextStyle(color: Colors.redAccent)),
        content: const Text(
          "Are you sure you want to log out?",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white70),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text("Log Out"),
            onPressed: () {
              logout();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
