import 'package:flutter/material.dart';

Widget TextFieldStudentCustom(
    BuildContext context, String name, TextEditingController myController) {
  return Container(
    height: MediaQuery.of(context).size.width * 0.050,
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.20,
      child: TextFormField(
        controller: myController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Required';
          }

          return null;
        },
        decoration: InputDecoration(
            hintText: name,
            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            hintStyle: TextStyle(fontSize: 12),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    ),
  );
}

Widget TextFieldStudentID(
    BuildContext context, String name, TextEditingController myController) {
  return Container(
    height: MediaQuery.of(context).size.width * 0.050,
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.20,
      child: TextFormField(
        controller: myController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Required';
          }
          if (value.length > 9 || value.length < 9) {
            return 'Student ID should must be = 9';
          }

          final n = int.tryParse(value);
          if (n == null) {
            return 'Please enter a vaild number';
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: name,
            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            hintStyle: TextStyle(fontSize: 12),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    ),
  );
}

Widget TextFieldAdminCustomName(
    BuildContext context, Widget icon, TextEditingController myController) {
  return Container(
    height: MediaQuery.of(context).size.width * 0.048,
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.20,
      child: TextFormField(
        controller: myController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Required';
          }
          return null;
        },
        decoration: InputDecoration(
            suffixIcon: icon,
            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            hintStyle: TextStyle(fontSize: 12),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    ),
  );
}
