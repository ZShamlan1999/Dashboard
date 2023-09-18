// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TextFieldTeacher extends StatelessWidget {
  String employee_id;
  String teacher_name;
  String degree_type;
  TextEditingController employeeidController;
  TextEditingController teachernameController;
  TextEditingController degreetypeController;
  TextFieldTeacher(
      {required this.employee_id,
      required this.teacher_name,
      required this.degree_type,
      required this.employeeidController,
      required this.teachernameController,
      required this.degreetypeController});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      FieldTextEmployeeID(context, employeeidController, employee_id),
      FieldText(context, teachernameController, teacher_name),
      FieldText(context, degreetypeController, degree_type),
    ]);
  }
}

Widget FieldText(
    BuildContext context, TextEditingController myController, String text) {
  return Container(
    height: MediaQuery.of(context).size.width * 0.047,
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
            hintText: text,
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

Widget FieldTextEmployeeID(
    BuildContext context, TextEditingController myController, String text) {
  return Container(
    height: MediaQuery.of(context).size.width * 0.047,
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.20,
      child: TextFormField(
        controller: myController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Required';
          }
          if (value.length > 6 || value.length < 6) {
            return 'Em ID should must be = 6';
          }

          final n = int.tryParse(value);
          if (n == null) {
            return 'Please enter a vaild number';
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: text,
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
