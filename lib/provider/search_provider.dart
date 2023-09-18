// import 'package:dashboard/constent/crud.dart';
// import 'package:dashboard/constent/linkapi.dart';
// import 'package:dashboard/provider/provider.dart';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../screens/search/screens/search_result_teacher.dart';
// import '../screens/search/screens/serach_result_student.dart';

// class Search_Provider extends ChangeNotifier {
//   Crud crud = Crud();

//   searchIOfStudent(BuildContext context, searchtext) async {
//     Map<String, dynamic> dataList;
//     var response = await crud
//         .postRequest(linkSearchOfStudent, {'student_id': searchtext}, {});
//     if (response['status'] == 'Success') {
//       dataList = response['data'][0];
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>
//                 Search_Result_Student(dataList_Result: dataList),
//           ));

//       //   context.read<MyProvider>().changeCurentPageIndex(4);
//     } else if (response['status'] == 'Fail') {
//       searchErrorDialog(context);
//     } else {
//       print('SSSS');
//     }
//   }

//   searchIOfTeacher(BuildContext context, searchtext) async {
//     Map<String, dynamic>? dataList;
//     var response = await crud
//         .postRequest(linkSearchOfTeacher, {'employee_id': searchtext}, {});
//     if (response['status'] == 'Success') {
//       dataList = response['data'][0];
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>
//                 Search_Result_Teacher(dataListTeacher: dataList!),
//           ));
//     } else if (response['status'] == 'Fail') {
//       searchErrorDialog(context);
//     } else {
//       print('SSSS');
//     }
//   }

//   searchErrorDialog(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           actions: [
//             TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text(
//                   "OK",
//                   style: TextStyle(color: Colors.blue),
//                 ))
//           ],
//           title: Text(
//             "Errror".toUpperCase(),
//             style: TextStyle(color: Colors.red),
//           ),
//           content: Text('This User is Not Found..!'),
//         );
//       },
//     );
//   }
// }
