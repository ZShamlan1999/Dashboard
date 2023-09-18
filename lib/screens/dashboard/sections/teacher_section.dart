import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/provider.dart';
import '../../../provider/teacher_provider.dart';
import '../../teacher/screens/editteacher.dart';

class Teachers_Section extends StatelessWidget {
  const Teachers_Section({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Teachers',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<MyProvider>().changeCurentPageIndex(2);
                },
                child: Row(
                  children: [
                    Text('See All Teachers '),
                    Icon(Icons.arrow_right_alt_sharp)
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Consumer<Teacher_Provider>(
                builder: (context, value, child) {
                  return DataTable(
                      columns: [
                        ColumnName('Employee ID'),
                        ColumnName('Teacher Name'),
                        ColumnName('Degree type'),
                        ColumnName(''),
                      ],
                      rows: value.teachers
                          .take(2)
                          .map(
                            (teacher) => DataRow(cells: [
                              DataCell(Text(teacher.employeeID.toString())),
                              DataCell(Text(teacher.fullName)),
                              DataCell(Text(teacher.degreeType)),
                              DataCell(Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Edit_Button_Teacher(teacher, context),
                                  Delete_Button_Teacher(
                                      context, value, teacher),
                                ],
                              )),
                            ]),
                          )
                          .toList());
                },
              )),
        ],
      ),
    );
  }

  DataColumn ColumnName(String name) {
    return DataColumn(
        label:
            Text(name, style: TextStyle(fontSize: 18, fontFamily: 'Lexend')));
  }

  Delete_Button_Teacher(context, Teacher_Provider provider, teacher) {
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

  Widget Edit_Button_Teacher(teacher, BuildContext context) {
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

  Widget AlertToDelete(BuildContext context, Function() onDelete) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Are your sure delete this account ?'),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: onDelete, child: Text('Ok')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'))
          ],
        )
      ]),
    );
  }
}
