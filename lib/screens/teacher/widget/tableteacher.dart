import 'package:dashboard_esmani/constent/constant.dart';
import 'package:dashboard_esmani/provider/teacher_provider.dart';
import 'package:dashboard_esmani/screens/teacher/screens/editteacher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../component/alert_delete.dart';

class DataTableTeacher extends StatefulWidget {
  @override
  State<DataTableTeacher> createState() => _DataTableTeacherState();
}

class _DataTableTeacherState extends State<DataTableTeacher> {
  @override
  void initState() {
    Provider.of<Teacher_Provider>(context, listen: false).allTeachers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<Teacher_Provider>(
        builder: (context, value, child) {
          return value.teacher.isEmpty
              ? Text(
                  'Does not have any teachers',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              : Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kThirdColor,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: DataTable(
                      columns: [
                        ColumnName('Employee ID'),
                        ColumnName('Teacher Name'),
                        ColumnName('Degree Type'),
                        ColumnName('')
                      ],
                      rows: value.teachers
                          .map((teacher) => DataRow(cells: [
                                DataCell(Text(teacher.employeeID.toString())),
                                DataCell(Text(teacher.fullName)),
                                DataCell(Text(teacher.degreeType)),
                                DataCell(Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Edit_Button(teacher, context),
                                    Delete_Button(context, value, teacher),
                                  ],
                                )),
                              ]))
                          .toList()));
        },
      ),
    );
  }

  Delete_Button(BuildContext context, Teacher_Provider provider, teacher) {
    return MaterialButton(
      child: Text(
        'Delete',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        final AlertDialog alert = AlertDialog(
          shape: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: AlertToDelete(
            context,
            () {
              Navigator.pop(context);
              provider.deleteTeacher(context, teacher.accountNo);
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

  MaterialButton Edit_Button(teacher, BuildContext context) {
    return MaterialButton(
      onPressed: () {
        final AlertDialog alert = AlertDialog(
          shape: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: EditTeacher(infoTeacher: teacher),
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
