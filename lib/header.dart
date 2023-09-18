import 'package:dashboard_esmani/constent/crud.dart';
import 'package:dashboard_esmani/constent/linkapi.dart';
import 'package:dashboard_esmani/provider/student_provider.dart';
import 'package:dashboard_esmani/provider/teacher_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Header extends StatefulWidget {
  final String titlePage;

  Header({super.key, required this.titlePage});
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  TextEditingController searchtext = TextEditingController();

  Crud crud = Crud();
  searchIOfStudent() async {
    Map<String, dynamic> dataList;
    var response = await crud.postRequest(
        linkSearchOfStudent, {'student_id': searchtext.text}, {});
    if (response['status'] == 'Success') {
      dataList = response['data'][0];
      context.read<Student_Provider>().addSearchResult(dataList);
      //   context.read<MyProvider>().changeCurentPageIndex(5);
    } else if (response['status'] == 'Fail') {
      print('Student does not found');
    } else {
      print('SSSS');
    }
  }

  searchIOfTeacher() async {
    Map<String, dynamic>? dataList;
    var response = await crud.postRequest(
        linkSearchOfTeacher, {'employee_id': searchtext.text}, {});
    if (response['status'] == 'Success') {
      dataList = response['data'][0];
      context.read<Teacher_Provider>().addSearchResult(dataList!);
      //   context.read<MyProvider>().changeCurentPageIndex(5);
    } else if (response['status'] == 'Fail') {
      print('Teacher does not found');
    } else {
      print('SSSS');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.titlePage,
          style: TextStyle(
            fontSize: 35,
            fontFamily: 'Lexend',
            letterSpacing: 2,
          ),
        ),
        Spacer(
          flex: 2,
        ),
        Container(
          padding: EdgeInsets.only(right: 40),
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.height * 0.05,
          child: TextField(
              controller: searchtext,
              onSubmitted: (value) {
                print(value);
                searchIOfStudent();

                //   context.read<MyProvider>().changeCurentPageIndex(6) ;
                //     searchIOfTeacher();

                //  context.read<MyProvider>().changeCurentPageIndex(5);
                searchtext.clear();
              },
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
        ),
      ],
    );
  }
}
