import 'dart:convert';
import 'package:flutter/material.dart';
import '../constent/crud.dart';
import '../constent/linkapi.dart';
import 'package:http/http.dart' as http;
import '../main_scrreen.dart';
import '../models/teacher.dart';

class Teacher_Provider extends ChangeNotifier {
  Crud crud = Crud();
  List teachers = [];

  List<dynamic> get teacher => teachers;

  Map<String, dynamic> searchResultList = {};
  allTeachers() async {
    var url = linkShowAllTeacherss;
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      teachers = List<TeacherModel>.from(
          jsonData.map((data) => TeacherModel.fromJson(data)));
    } else {
      throw Exception('Data Is Faild');
    }
    notifyListeners();
  }

  insertTeacher(BuildContext context, String employeeID, String teacherName,
      String degreetype) async {
    var response = await crud.postRequest(linkInsertTeachers, {
      'employeeid': employeeID,
      'fullname': teacherName,
      'degreetype': degreetype
    }, {});
    if (response['status'] == "Success") {
      print('Done');
    } else {
      addTeacherErrorDialog(context);
    }
    notifyListeners();
  }

  addTeacherErrorDialog(BuildContext context) {
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
          content: Text('This Employee ID is Found..!'),
        );
      },
    );
  }

  editTeacher(BuildContext context, String employeeID, String teacherName,
      String degreetype, String accountNo) async {
    var response = await crud.postRequest(linkEditTeacher, {
      'employeeid': employeeID.toString(),
      'fullname': teacherName,
      'degreetype': degreetype,
      'accountno': accountNo.toString()
    }, {});
    if (response['status'] == "Success") {
      print('===========================');
      var route = MaterialPageRoute(
        builder: (context) => MainScreen(),
      );
      Navigator.push(context, route);
    } else {
      print('ErrrrOR');
    }
    notifyListeners();
  }

  deleteTeacher(BuildContext context, String accountNo) async {
    var response = await crud.postRequest(
        linkDeleteTeacher, {'accountno': accountNo.toString()}, {});
    if (response['status'] == "Success") {
      print(' Delete donnnnnne');
      var route = MaterialPageRoute(
        builder: (context) => MainScreen(),
      );
      Navigator.push(context, route);
    } else {
      print('Errrorr');
    }
    notifyListeners();
  }

  void addSearchResult(Map<String, dynamic> searchResult) {
    searchResultList.clear();
    searchResultList = searchResult;
    notifyListeners();
  }
}
