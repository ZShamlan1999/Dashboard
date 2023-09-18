import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback press;
  final int index;
  final int initIndex;
  DrawerListTile(
      {required this.title,
      required this.icon,
      required this.press,
      required this.index,
      required this.initIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        shape: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        hoverColor: Colors.grey[400],
        onTap: press,
        leading: icon,
        tileColor: initIndex == index
            ? Color.fromARGB(255, 196, 189, 187)
            : Colors.white,
        title: Text(
          '$title',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
