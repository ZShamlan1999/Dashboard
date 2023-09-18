import 'package:dashboard_esmani/main_scrreen.dart';
import 'package:dashboard_esmani/provider/student_provider.dart';
import 'package:dashboard_esmani/provider/teacher_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'provider/provider.dart';
import 'screens/login/Login.dart';

late SharedPreferences sharedpref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyProvider()),
        ChangeNotifierProvider(create: (context) => Student_Provider()),
        ChangeNotifierProvider(
          create: (context) => Teacher_Provider(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => Search_Provider(),
        // )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dashboard',
        initialRoute: sharedpref.getString('id') == null ? 'login' : 'home',
        home: MainScreen(),
        //HomePage(currentPage: DashboardScreen()),
        routes: {
          'login': (context) => LoginPage(),
          'home': (context) => MainScreen(),
          // 'students_page': (context) => StudentsScreen(),
          // 'teachers_page': (context) => TeachersScreen()
        },
      ),
    );
  }
}
