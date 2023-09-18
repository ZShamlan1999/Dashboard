import 'package:dashboard_esmani/constent/constant.dart';
import 'package:dashboard_esmani/provider/student_provider.dart';
import 'package:dashboard_esmani/screens/student/screens/editstudent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../component/alert_delete.dart';

class DataTableStudent extends StatefulWidget {
  @override
  State<DataTableStudent> createState() => _DataTableStudentState();
}

class _DataTableStudentState extends State<DataTableStudent> {
  @override
  void initState() {
    Provider.of<Student_Provider>(context, listen: false).allStudents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Consumer<Student_Provider>(
      builder: (context, value, child) {
        return value.student.isEmpty
            ? Text(
                'Does not have any students',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            : Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kThirdColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: DataTable(
                    columns: [
                      ColumnName('ID'),
                      ColumnName('Student Name'),
                      ColumnName('Depatrment'),
                      ColumnName('Level'),
                      ColumnName('MAC Address'),
                      ColumnName(''),
                    ],
                    rows: value.students
                        .map(
                          (student) => DataRow(cells: [
                            DataCell(Text(student.studentID.toString())),
                            DataCell(Text(student.fullName)),
                            DataCell(Text(student.department)),
                            DataCell(Text(student.level)),
                            DataCell(Text(student.macAddress.toString())),
                            DataCell(Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Edit_Button(student, context),
                                Delete_Button(context, value, student),
                              ],
                            )),
                          ]),
                        )
                        .toList()),
              );
      },
    ));
  }

  Widget Delete_Button(context, Student_Provider provider, student) {
    return MaterialButton(
      child: Text(
        'Delete',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        print(student.accountNo);
        final AlertDialog alert = AlertDialog(
          shape: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: AlertToDelete(
            context,
            () {
              Navigator.pop(context);

              provider.deleteStudent(context, student.accountNo);
            },
          ),
        );
        showDialog(
          context: context,
          builder: (context) {
            return alert;
          },
        );
      },
      color: Colors.red,
    );
  }

  Widget Edit_Button(student, BuildContext context) {
    return MaterialButton(
      onPressed: () {
        final AlertDialog alert = AlertDialog(
          shape: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: EditStudent(infostudent: student),
        );
        showDialog(
          context: context,
          builder: (context) {
            return alert;
          },
        );
      },
      color: Colors.green,
      minWidth: 40,
      child: Text(
        'Edit',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  DataColumn ColumnName(String name) {
    return DataColumn(
        label:
            Text(name, style: TextStyle(fontSize: 18, fontFamily: 'Lexend')));
  }
}
