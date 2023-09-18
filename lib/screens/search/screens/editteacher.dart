import 'package:dashboard_esmani/models/teacher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/teacher_provider.dart';
import '../../teacher/widget/textfieldcoustom.dart';

class EditTeacher extends StatefulWidget {
  final TeacherModel infoteacher;
  const EditTeacher({super.key, required this.infoteacher});
  @override
  State<EditTeacher> createState() => _EditTeacherState();
}

class _EditTeacherState extends State<EditTeacher> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController employeeID = TextEditingController();
  late TextEditingController teacherName = TextEditingController();
  late TextEditingController degreetype = TextEditingController();
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    print(widget.infoteacher.accountNo);
    employeeID.text = widget.infoteacher.employeeID;
    teacherName.text = widget.infoteacher.fullName;
    degreetype.text = widget.infoteacher.degreeType;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Teacher_Provider>(context, listen: false);
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      child: Form(
          key: formstate,
          child: Column(
            children: [
              Text(
                'Edit',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
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
                        Navigator.pop(context);
                        setState(() {
                          provider.editTeacher(
                              context,
                              employeeID.text,
                              teacherName.text,
                              degreetype.text,
                              widget.infoteacher.accountNo.toString());

                          employeeID.clear();
                          teacherName.clear();
                          degreetype.clear();
                        });
                      }
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    )),
              ),
            ],
          )),
    );
  }
}
