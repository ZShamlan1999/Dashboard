import 'package:dashboard_esmani/screens/dashboard/dashboard_screen.dart';
import 'package:dashboard_esmani/screens/profile/profile.dart';
import 'package:dashboard_esmani/screens/student/screens/student_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/provider.dart';
import 'screens/main/component/side_menu.dart';
import 'screens/profile/edit_admin_profile.dart';
import 'screens/teacher/screens/teacher_screen.dart';

class MainScreen extends StatelessWidget {
  final List<Widget> pages = [
    DashboardScreen(),
    Students(),
    Teachers(),
    ProfilePage(),
    EditAdminProfile(),
    //   Search_Result_Teacher(dataListTeacher: {}),
  ];

  @override
  Widget build(BuildContext context) {
    int currentIndex = context.watch<MyProvider>().curentPageIndex;
    return Scaffold(
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: SideMenu()),
          Expanded(flex: 4, child: pages.elementAt(currentIndex))
        ],
      )),
    );
  }
}
