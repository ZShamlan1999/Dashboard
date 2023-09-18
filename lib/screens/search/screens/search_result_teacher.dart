// import 'package:dashboard/screens/search/widget/search_result_teacher_table.dart';
// import 'package:flutter/material.dart';
// import '../../../constent/constant.dart';


// class Search_Result_Teacher extends StatefulWidget {
//   final  dataListTeacher;
//   Search_Result_Teacher({required this.dataListTeacher});

//   @override
//   State<Search_Result_Teacher> createState() => _Search_Result_TeacherState();
// }


// class _Search_Result_TeacherState extends State<Search_Result_Teacher> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: kPrimaryColorHomePage,
//         child: Container(
//           decoration: BoxDecoration(
//               color: kSecondaryColor,
//               borderRadius: BorderRadius.all(Radius.circular(20))),
//           margin: EdgeInsets.only(top: 10, right: 10, bottom: 10),
//           child: Column(
//             //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 height: 10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20.0),
//                 child: Text(
//                   'Search result',
//                   style: TextStyle(
//                     fontSize: 35,
//                     fontFamily: 'Lexend',
//                     letterSpacing: 2,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Expanded(
//                   child: Search_Result_Teacher_Table(
//                       dataList: widget.dataListTeacher)),
//             ],
//           ),
//         ));
//   }
// }
