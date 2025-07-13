import 'package:flutter/material.dart';
import 'Global.dart';
import 'Pages/fitness.dart';
import 'Pages/health.dart';
import 'Pages/home.dart';
import 'Pages/profile.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final List _page = [Homepage(), Fitpage(), Healthpage(), Profilepage()];

  double height = 0;
  double target = 1;

  void updatePage(int page) {
    setState(() {
      pageIndex = page;
      //set the variable to current page index
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.greenAccent[400],
          unselectedItemColor: Colors.grey[400],
          elevation: 100,
        ),
      ),
      home: Scaffold(
        //set current page
        body: _page[pageIndex],

        bottomNavigationBar: BottomNavigationBar(
          onTap: (page) {
            // page is current page index
            updatePage(page);
          },
          currentIndex: pageIndex,
          items: [
            //home
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',),

            //fit
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: 'Fitness',
            ),

            //health
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Health',
            ),

            //profile
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
