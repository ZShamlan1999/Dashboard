import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/provider.dart';
import '../../../provider/student_provider.dart';
import '../../student/screens/editstudent.dart';

class Students_Section extends StatefulWidget {
  const Students_Section({super.key});

  @override
  State<Students_Section> createState() => _Students_SectionState();
}

class _Students_SectionState extends State<Students_Section> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Students',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            InkWell(
              onTap: () {
                context.read<MyProvider>().changeCurentPageIndex(1);
              },
              child: Row(
                children: [
                  Text('See All Students '),
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
            child: Consumer<Student_Provider>(
              builder: (context, value, child) {
                return DataTable(
                    columns: [
                      ColumnName('ID'),
                      ColumnName('Student Name'),
                      ColumnName('Depatrment'),
                      ColumnName('Level'),
                      ColumnName('MAC Address'),
                      ColumnName(''),
                    ],
                    rows: value.students
                        .take(2)
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
                        .toList());
              },
            ))
      ]),
    );
  }

  DataColumn ColumnName(String name) {
    return DataColumn(
        label:
            Text(name, style: TextStyle(fontSize: 18, fontFamily: 'Lexend')));
  }

  MaterialButton Delete_Button(context, Student_Provider provider, student) {
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
          content: AlertToDelete(context, () {
            Navigator.pop(context);
            provider.deleteStudent(context, student.accountNo);
          }),
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

  MaterialButton Edit_Button(student, BuildContext context) {
    return MaterialButton(
      onPressed: () {
        final AlertDialog alert = AlertDialog(
          shape: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: EditStudent(
            infostudent: student,
          ),
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
