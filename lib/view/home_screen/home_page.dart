import 'package:flutter/material.dart';
import 'package:rtd_project/core/color/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0.0, 1.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: BottomNavigationBar(
                  selectedItemColor: whiteColor,
                  unselectedItemColor: Colors.grey,
                  showSelectedLabels: true,
                  showUnselectedLabels: false,
                  backgroundColor: Colors.black,
                  items: [
                    BottomNavigationBarItem(icon: Icon(Icons.home),label: 'home'),
                     BottomNavigationBarItem(icon: Icon(Icons.home),label: 'home'),
                      BottomNavigationBarItem(icon: Icon(Icons.home),label: 'home'),
                       BottomNavigationBarItem(icon: Icon(Icons.home),label: 'home'),
                        BottomNavigationBarItem(icon: Icon(Icons.home),label: 'home'),
                  ]),
            ),
          )
        ],
      ),
    ));
  }
}
