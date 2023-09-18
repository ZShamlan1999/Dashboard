import 'package:dashboard_esmani/constent/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/provider.dart';
import 'drawerListTile.dart';

class SideMenu extends StatefulWidget {
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    int _initIndex = context.watch<MyProvider>().curentPageIndex;
    return Drawer(
      child: Container(
        //  height: MediaQuery.of(context).size.height,
        color: kPrimaryColorHomePage,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Logo(),
              SizedBox(
                height: 80,
              ),
              DrawerListTile(
                title: 'Home',
                index: 0,
                initIndex: _initIndex,
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                press: () {
                  context.read<MyProvider>().changeCurentPageIndex(0);
                },
              ),
              DrawerListTile(
                title: 'Student',
                index: 1,
                initIndex: _initIndex,
                icon: Icon(Icons.person, color: Colors.white),
                press: () {
                  context.read<MyProvider>().changeCurentPageIndex(1);
                },
              ),
              DrawerListTile(
                title: 'Teachers',
                index: 2,
                initIndex: _initIndex,
                icon: Icon(Icons.person_outline, color: Colors.white),
                press: () {
                  context.read<MyProvider>().changeCurentPageIndex(2);
                },
              ),
              DrawerListTile(
                title: 'Profile',
                index: 3,
                initIndex: _initIndex,
                icon: Icon(Icons.person_pin_rounded, color: Colors.white),
                press: () {
                  context.read<MyProvider>().changeCurentPageIndex(3);
                },
              ),
              DrawerListTile(
                title: 'LogOut',
                index: 7,
                initIndex: _initIndex,
                icon: Icon(Icons.logout, color: Colors.white),
                press: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('login', (route) => false);
                },
              ),
              SizedBox(
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Logo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 75),
      child: Text(
        'ESMANI',
        style: TextStyle(
            letterSpacing: 8,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
    );
  }
}
