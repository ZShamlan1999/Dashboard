import 'package:dashboard_esmani/constent/constant.dart';
import 'package:dashboard_esmani/provider/student_provider.dart';
import 'package:dashboard_esmani/screens/search/screens/editstudent.dart';
import 'package:dashboard_esmani/screens/student/screens/student_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../component/alert_delete.dart';

class Search_Result_Student_Table extends StatefulWidget {
  final Map<String, dynamic> dataList;
  Search_Result_Student_Table({required this.dataList});
  @override
  State<Search_Result_Student_Table> createState() =>
      _Search_Result_Student_TableState();
}

Students st = Students();

class _Search_Result_Student_TableState
    extends State<Search_Result_Student_Table> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Student_Provider>(
      builder: (context, value, child) {
        return widget.dataList.isEmpty
            ? Text(
                'The student is not found',
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
                    ColumnName('Mac Address'),
                    ColumnName(''),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text(widget.dataList['StudentID'].toString())),
                      DataCell(Text(widget.dataList['FullName'])),
                      DataCell(Text(widget.dataList['Department'])),
                      DataCell(Text(widget.dataList['Level'])),
                      DataCell(Text(widget.dataList['MacAddress'].toString())),
                      DataCell(Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Edit_Button(context, widget.dataList),
                          Delete_Button(context, value),
                        ],
                      )),
                    ])
                  ],
                ));
      },
    );
  }

  MaterialButton Delete_Button(
      BuildContext context, Student_Provider provider) {
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

              provider.deleteStudent(context, widget.dataList['AccountNo']);
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

  MaterialButton Edit_Button(BuildContext context, dataList) {
    return MaterialButton(
      onPressed: () {
        print('====================================');
        print(widget.dataList['AccountNo']);
        final AlertDialog alert = AlertDialog(
          shape: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: EditStudent(infostudent: dataList),
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
