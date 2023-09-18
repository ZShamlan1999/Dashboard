import 'package:flutter/material.dart';

Widget headerTitle(String title) {
  return Text(
    title,
    style: TextStyle(
      fontSize: 35,
      fontFamily: 'Lexend',
      letterSpacing: 2,
    ),
  );
}

Widget headerSearchCard(BuildContext context, VoidCallback onPressed,
    TextEditingController controller) {
  return Container(
    padding: EdgeInsets.only(right: 40),
    width: MediaQuery.of(context).size.width * 0.25,
    height: MediaQuery.of(context).size.height * 0.05,
    child: TextField(
        controller: controller,
        onSubmitted: (value) => onPressed(),
        showCursor: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 3),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search',
          labelStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[400],
          ),
        )),
  );
}
