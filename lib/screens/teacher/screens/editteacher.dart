import 'package:dashboard_esmani/models/teacher.dart';
import 'package:dashboard_esmani/provider/teacher_provider.dart';
import 'package:dashboard_esmani/screens/teacher/widget/textfieldcoustom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTeacher extends StatefulWidget {
  final TeacherModel infoTeacher;

  const EditTeacher({super.key, required this.infoTeacher});
  @override
  State<EditTeacher> createState() => _EditTeacherState();
}

class _EditTeacherState extends State<EditTeacher> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController employeeID = TextEditingController();
  late TextEditingController teacherName = TextEditingController();
  late TextEditingController degreetype = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(widget.infoTeacher.accountNo);
    employeeID.text = widget.infoTeacher.employeeID;
    teacherName.text = widget.infoTeacher.fullName;
    degreetype.text = widget.infoTeacher.degreeType;
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
                              widget.infoTeacher.accountNo.toString());

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
