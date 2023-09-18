import 'package:dashboard_esmani/constent/constant.dart';
import 'package:dashboard_esmani/provider/teacher_provider.dart';
import 'package:dashboard_esmani/screens/search/screens/editteacher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../component/alert_delete.dart';

class Search_Result_Teacher_Table extends StatefulWidget {
  final Map<String, dynamic> dataList;
  Search_Result_Teacher_Table({super.key, required this.dataList});
  @override
  State<Search_Result_Teacher_Table> createState() =>
      _Search_Result_Teacher_TableState();
}

class _Search_Result_Teacher_TableState
    extends State<Search_Result_Teacher_Table> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Teacher_Provider>(
      builder: (context, value, child) {
        return widget.dataList.isEmpty
            ? Text(
                'The teacher is not found',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            : Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kThirdColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: DataTable(columns: [
                  ColumnName('EmployeeID'),
                  ColumnName('Teacher Name'),
                  ColumnName('Degree Type'),
                  ColumnName(''),
                ], rows: [
                  DataRow(cells: [
                    DataCell(Text(widget.dataList['EmployeeID'])),
                    DataCell(Text(widget.dataList['FullName'])),
                    DataCell(Text(widget.dataList['DegreeType'])),
                    DataCell(Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Edit_Button(context),
                        Delete_Button(context, value),
                      ],
                    )),
                  ]),
                ]));
      },
    );
  }

  MaterialButton Delete_Button(
      BuildContext context, Teacher_Provider provider) {
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

              provider.deleteTeacher(context, widget.dataList['AccountNo']);
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

  MaterialButton Edit_Button(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        final AlertDialog alert = AlertDialog(
          shape: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: EditTeacher(infoteacher: widget.dataList['']),
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
