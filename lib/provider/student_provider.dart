import 'dart:convert';
import 'package:dashboard_esmani/constent/crud.dart';
import 'package:dashboard_esmani/main_scrreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constent/linkapi.dart';
import '../models/student.dart';

class Student_Provider extends ChangeNotifier {
  Crud crud = Crud();
  List students = [];
  List<dynamic> get student => students;
  Map<String, dynamic> searchResultList = {};

  allStudents() async {
    final url = linkShowAllStudents;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      students = List<StudentsModel>.from(
          jsonData.map((data) => StudentsModel.fromJson(data)));
      notifyListeners();
    } else {
      throw Exception('Failed to load data ');
    }
  }

  insertStudent(
      BuildContext context,
      String studentname,
      String selectedDepartmentOption,
      String selectedLevelOption,
      String studentid) async {
    var response = await crud.postRequest(linkInsertStudent, {
      'fullname': studentname,
      'department': selectedDepartmentOption.toString(),
      'level': selectedLevelOption.toString(),
      'studentid': studentid
    }, {});
    if (response['status'] == "Success") {
      print('Done');
    } else if (response['status'] == "Fail") {
      addStudentErrorDialog(context);
    } else {
      print('=============================');
      print(response);
    }
    notifyListeners();
  }

  addStudentErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.blue),
                ))
          ],
          title: Text(
            "Errror".toUpperCase(),
            style: TextStyle(color: Colors.red),
          ),
          content: Text('This Student ID is Found..!'),
        );
      },
    );
  }

  editStudent(
      BuildContext context,
      String studentname,
      String selectedDepartmentOption,
      String selectedLevelOption,
      String mac,
      String studentid,
      String accountNo) async {
    var response = await crud.postRequest(linkEditStudent, {
      'fullname': studentname,
      'department': selectedDepartmentOption.toString(),
      'level': selectedLevelOption.toString(),
      'macaddress': mac,
      'studentid': studentid,
      'accountno': accountNo.toString()
    }, {});
    if (response['status'] == "Success") {
      print('Edit Donnnnnnnnnnnnnnne');
      var route = MaterialPageRoute(
        builder: (context) => MainScreen(),
      );
      Navigator.push(context, route);
    } else {
      print('ErrrrOR');
    }
    notifyListeners();
  }

  deleteStudent(BuildContext context, String accountNo) async {
    var response = await crud.postRequest(
        linkDeleteStudent, {'accountno': accountNo.toString()}, {});
    if (response['status'] == "Success") {
      print(' Delete donnnnnne');
      var route = MaterialPageRoute(
        builder: (context) => MainScreen(),
      );
      Navigator.push(context, route);
    }
    notifyListeners();
  }

  void addSearchResult(Map<String, dynamic> searchResult) {
    searchResultList.clear();
    searchResultList = searchResult;
    notifyListeners();
  }
}
