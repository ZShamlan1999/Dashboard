import 'package:dashboard_esmani/constent/constant.dart';
import 'package:dashboard_esmani/constent/crud.dart';
import 'package:dashboard_esmani/provider/student_provider.dart';
import 'package:dashboard_esmani/provider/teacher_provider.dart';
import 'package:dashboard_esmani/screens/dashboard/sections/student_section.dart';
import 'package:dashboard_esmani/screens/dashboard/sections/teacher_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constent/linkapi.dart';
import '../component/headerComponent.dart';
import '../search/widget/search_result_student_table.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>{
  int pageMode = 1;
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    Provider.of<Teacher_Provider>(context, listen: false).allTeachers();
    Provider.of<Student_Provider>(context, listen: false).allStudents();
    super.initState();
  }

  Crud  crud = Crud ();
  @override
  Widget build(BuildContext context) {
    return Container(
        color: kPrimaryColorHomePage,
        child: Container(
          decoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: EdgeInsets.only(top: 10, right: 10, bottom: 10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    headerTitle(pageMode == 1 ? "Home" : "Search Result"),
                    Spacer(flex: 2),
                    headerSearchCard(context, () async {
                      await searchIOfStudent();
                      await searchIOfTeacher();
                      setState(() {
                        pageMode = 0;
                      });
                      _controller.clear();
                    }, _controller)
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              pageMode == 1
                  ? defualtMode()
                  : Search_Result_Student_Table(
                      dataList:
                          context.watch<Student_Provider>().searchResultList,
                    )
              // : Search_Result_Teacher_Table(
              //     dataList: context
              //         .watch<Teacher_Provider>()
              //         .searchResultList,
              //   ),
            ],
          ),
        ));
  }

  Widget defualtMode() {
    return Column(
      children: [
        Students_Section(),
        SizedBox(
          height: 50,
        ),
        Teachers_Section()
      ],
    );
  }

  searchIOfStudent() async {
    Map<String, dynamic> dataList;
    var response = await crud.postRequest(
        linkSearchOfStudent, {'student_id': _controller.text}, {});
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
        linkSearchOfTeacher, {'employee_id': _controller.text}, {});
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
}
