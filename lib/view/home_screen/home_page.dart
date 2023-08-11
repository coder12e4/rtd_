import 'package:flutter/material.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/view/book_screen/book_page.dart';
import 'package:rtd_project/view/home_screen/home.dart';
import 'package:rtd_project/view/loan_screen/loan_page.dart';
import 'package:rtd_project/view/wall_screen/wall_page.dart';

import '../profile_screen/profile_page.dart';

class NavigationBarpage extends StatefulWidget {
  const NavigationBarpage({super.key});

  @override
  State<NavigationBarpage> createState() => _NavigationBarpageState();
}

class _NavigationBarpageState extends State<NavigationBarpage> {
  int _pageindex = 0;
  final List<Widget> _tablist = [
    HomePage(),
    WallPage(),
    BookPage(),
    LoanPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          _tablist.elementAt(_pageindex),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Align(
              alignment: Alignment(0.0, 1.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: BottomNavigationBar(
                    selectedItemColor: whiteColor,
                    unselectedItemColor: Colors.grey,
                    showSelectedLabels: true,
                    showUnselectedLabels: false,
                    backgroundColor: Colors.amber,
                    currentIndex: _pageindex,
                    onTap: (int index) {
                      setState(() {
                        _pageindex = index;
                      });
                    },
                    items: const [
                      BottomNavigationBarItem(
                          backgroundColor: Colors.black,
                          icon: Icon(Icons.home),
                          label: 'home'),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.black,
                          icon: Icon(Icons.home), label: 'home'),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.black,
                          icon: Icon(Icons.home), label: 'home'),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.black,
                          icon: Icon(Icons.home), label: 'home'),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.black,
                          icon: Icon(Icons.home), label: 'home'),
                    ]),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
