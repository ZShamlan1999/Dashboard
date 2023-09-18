import 'package:dashboard_esmani/constent/constant.dart';
import 'package:dashboard_esmani/constent/crud.dart';
import 'package:dashboard_esmani/constent/linkapi.dart';
import 'package:dashboard_esmani/provider/student_provider.dart';
import 'package:dashboard_esmani/screens/component/headerComponent.dart';
import 'package:dashboard_esmani/screens/student/widget/tablestudent.dart';
import 'package:dashboard_esmani/screens/student/widget/textfieldcoustom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../search/widget/search_result_student_table.dart';

class Students extends StatefulWidget {
  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  int pageMode = 1;
  TextEditingController _controller = TextEditingController();
  Crud crud =Crud();
  @override
  Widget build(BuildContext context) {
    return Container(
        color: kPrimaryColorHomePage,
        child: Consumer(
          builder: (context, value, child) {
            return Container(
              decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              margin: EdgeInsets.only(top: 10, right: 10, bottom: 10),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        headerTitle(
                            pageMode == 1 ? "Students" : "Search Result"),
                        Spacer(flex: 2),
                        headerSearchCard(context, () async {
                          await searchIOfStudent();
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
                          dataList: context
                              .watch<Student_Provider>()
                              .searchResultList,
                        ),
                  pageMode == 1 ? newStudentButton(context) : empty()
                ],
              ),
            );
          },
        ));
  }

  Widget newStudentButton(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      child: MaterialButton(
          child: Row(children: [
            Icon(Icons.add),
            Text(
              'Add new Student',
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

  Widget empty() {
    return Spacer();
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
        return DataTableStudent();
      },
    ));
  }

  AlertDialog AlertToInsert(BuildContext context) {
    var provider = Provider.of<Student_Provider>(context, listen: false);
    GlobalKey<FormState> formstate = GlobalKey<FormState>();
    TextEditingController studentname = TextEditingController();
    TextEditingController studentid = TextEditingController();
    String? _selectedLevelOption;
    String? _selectedDepartmentOption;
    List<String> departmentList = ['IT', 'CS'];
    List<String> levelList = ['1', '2', '3', '4'];

    fieldsClear() {
      studentid.clear();
      studentname.clear();
      _selectedDepartmentOption;
      _selectedLevelOption;
    }

    return AlertDialog(
      shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      title: Center(child: Text('Add Student')),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Form(
            key: formstate,
            child: Column(
              children: [
                TextFieldStudentID(
                  context,
                  'Student ID',
                  studentid,
                ),
                SizedBox(
                  height: 3,
                ),
                TextFieldStudentCustom(
                  context,
                  'Student Name',
                  studentname,
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.035,
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: DropdownButtonFormField<String>(
                    hint: Text(
                      'Department',
                    ),
                    value: _selectedDepartmentOption,
                    onChanged: (String? newValue) {
                      _selectedDepartmentOption = newValue;
                    },
                    items: departmentList.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.035,
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: DropdownButtonFormField<String>(
                    hint: Text('Level'),
                    value: _selectedLevelOption,
                    onChanged: (String? newValue) {
                      _selectedLevelOption = newValue;
                    },
                    items: levelList.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
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
                          Navigator.pop(context);
                          setState(() {
                            provider.insertStudent(
                              context,
                              studentname.text,
                              _selectedDepartmentOption.toString(),
                              _selectedLevelOption.toString(),
                              studentid.text,
                            );
                          });
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

  DataColumn ColumnName(String name) {
    return DataColumn(
        label:
            Text(name, style: TextStyle(fontSize: 18, fontFamily: 'Lexend')));
  }

  searchIOfStudent() async {
    Map<String, dynamic> dataList;
    var response = await crud.postRequest(
        linkSearchOfStudent, {'student_id': _controller.text}, {});
    if (response['status'] == 'Success') {
      dataList = response['data'][0];
      if (dataList.isNotEmpty) {
        context.read<Student_Provider>().addSearchResult(dataList);
      } else {
        print('Nor Found');
      }

      //   context.read<MyProvider>().changeCurentPageIndex(5);
    } else if (response['status'] == 'Fail') {
      print('Student does not found');
    } else {
      print('SSSS');
    }
  }
}
