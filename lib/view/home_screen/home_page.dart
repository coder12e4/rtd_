import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/core/color/colors.dart';

import '../../controller/bottom_navigation_controller.dart';
import '../book_screen/book_page.dart';
import '../loan_screen/loan_page.dart';
import '../profile_screen/profile_page.dart';
import '../wall_screen/wall_page.dart';
import 'home.dart';

class NavigationBarpage extends StatefulWidget {
  const NavigationBarpage({super.key});

  @override
  State<NavigationBarpage> createState() => _NavigationBarpageState();
}

class _NavigationBarpageState extends State<NavigationBarpage> {
  final List<Widget> _tablist = [
     HomePage(),
    const WallPage(),
    const LoanPage(),
    BookPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      builder: (value) {
        return SafeArea(
            child: DefaultTabController(
          length: _tablist.length,
          child: Scaffold(
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: value.tabController,
              children: _tablist,
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8).r,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: BottomNavigationBar(
                    selectedItemColor: whiteColor,
                    unselectedItemColor: Colors.grey,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    // backgroundColor: Colors.amber,
                    currentIndex: value.pageIndex!,
                    onTap: (int index) {
                      value.updateTabId(index);
                    },
                    items: const [
                      BottomNavigationBarItem(
                          backgroundColor: Colors.black,
                          icon: Icon(Icons.home),
                          label: 'Home'),
                      BottomNavigationBarItem(
                          backgroundColor: Colors.black,
                          icon: Icon(Icons.repeat),
                          label: 'Wall'),
                      BottomNavigationBarItem(
                          backgroundColor: Colors.black,
                          icon: Icon(Icons.add_box_outlined),
                          label: 'Loan'),
                      BottomNavigationBarItem(
                          backgroundColor: Colors.black,
                          icon: Icon(Icons.book_outlined),
                          label: 'Book'),
                      BottomNavigationBarItem(
                          backgroundColor: Colors.black,
                          icon: Icon(Icons.person_2_outlined),
                          label: 'Profile'),
                    ]),
              ),
            ),
          ),
        ));
      },
    );
  }
}
