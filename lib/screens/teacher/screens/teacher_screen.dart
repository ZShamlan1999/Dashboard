import 'package:dashboard_esmani/constent/constant.dart';
import 'package:dashboard_esmani/constent/crud.dart';
import 'package:dashboard_esmani/provider/teacher_provider.dart';
import 'package:dashboard_esmani/screens/search/widget/search_result_teacher_table.dart';
import 'package:dashboard_esmani/screens/teacher/widget/tableteacher.dart';
import 'package:dashboard_esmani/screens/teacher/widget/textfieldcoustom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constent/linkapi.dart';
import '../../component/headerComponent.dart';

class Teachers extends StatefulWidget {
  @override
  State<Teachers> createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> {
  int pageMode = 1;
  TextEditingController _controller = TextEditingController();
  Crud crud = Crud();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: kPrimaryColorHomePage,
          child: Consumer(
            builder: (context, value, child) {
              return Container(
                decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                margin: EdgeInsets.only(top: 10, right: 10, bottom: 10),
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        headerTitle(
                            pageMode == 1 ? "Teachers" : "Search Result"),
                        Spacer(flex: 2),
                        headerSearchCard(context, () async {
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
                      : Search_Result_Teacher_Table(
                          dataList: context
                              .watch<Teacher_Provider>()
                              .searchResultList,
                        ),
                  pageMode == 1 ? newTeacherButton(context) : empty()
                ]),
              );
            },
          )),
    );
  }

  Widget newTeacherButton(context) {
    return Container(
      width: 200,
      height: 50,
      child: MaterialButton(
          child: Row(children: [
            Icon(Icons.add),
            Text(
              'Add new teacher',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ]),
          onPressed: () {
            final AlertDialog alert = AlertToInsert(context);
            showDialog(
              context: context,
              builder: (context) {
                return alert;
              },
            );
          }),
    );
  }

  Widget defualtMode() {
    return Expanded(
        child: FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return DataTableTeacher();
      },
    ));
  }

  Widget empty() {
    return Spacer();
  }

  AlertDialog AlertToInsert(BuildContext context) {
    var provider = Provider.of<Teacher_Provider>(context, listen: false);
    GlobalKey<FormState> formstate = GlobalKey<FormState>();
    TextEditingController employeeID = TextEditingController();
    TextEditingController teacherName = TextEditingController();
    TextEditingController degreetype = TextEditingController();

    fieldsClear() {
      employeeID.clear();
      teacherName.clear();
      degreetype.clear();
    }

    return AlertDialog(
      shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      title: Center(child: Text('Add Teacher')),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.40,
        child: Form(
            key: formstate,
            child: Column(
              children: [
                TextFieldTeacher(
                  employeeidController: employeeID,
                  employee_id: 'Employee ID',
                  teachernameController: teacherName,
                  teacher_name: 'Teacher Name',
                  degreetypeController: degreetype,
                  degree_type: 'Degree Type',
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(style: BorderStyle.solid, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  width: MediaQuery.of(context).size.width * 0.09,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white)),
                      onPressed: () {
                        if (formstate.currentState!.validate()) {
                          setState(() {
                            provider.insertTeacher(context, employeeID.text,
                                teacherName.text, degreetype.text);
                          });
                          Navigator.pop(context);
                          fieldsClear();
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )),
                ),
              ],
            )),
      ),
    );
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
