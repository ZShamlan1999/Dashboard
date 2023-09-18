import 'package:dashboard_esmani/models/student.dart';
import 'package:dashboard_esmani/provider/student_provider.dart';
import 'package:dashboard_esmani/screens/student/widget/textfieldcoustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditStudent extends StatefulWidget {
  final StudentsModel infostudent;

  const EditStudent({super.key, required this.infostudent});
  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController studentname = TextEditingController();
  TextEditingController studentid = TextEditingController();
  String? selectedLevelOption;
  String? selectedDepartmentOption;
  List<String> departmentList = ['IT', 'CS'];
  List<String> levelList = ['1', '2', '3', '4'];

  TextEditingController mac = TextEditingController();
  TextEditingController cont1 = TextEditingController();
  TextEditingController cont2 = TextEditingController();
  TextEditingController cont3 = TextEditingController();
  TextEditingController cont4 = TextEditingController();
  TextEditingController cont5 = TextEditingController();
  TextEditingController cont6 = TextEditingController();

  String newMac = '';
  String lastMac = "";

  preformeMac() {
    for (int i = 0; i < mac.text.length; i++) {
      if (i >= 0 && i < 2) {
        cont1.text += mac.text[i];
      }
      if (i > 2 && i < 5) {
        cont2.text += mac.text[i];
      }
      if (i > 5 && i < 8) {
        cont3.text += mac.text[i];
      }
      if (i > 8 && i < 11) {
        cont4.text += mac.text[i];
      }
      if (i > 11 && i < 14) {
        cont5.text += mac.text[i];
      }
      if (i > 14 && i < 17) {
        cont6.text += mac.text[i];
      }
      if (i > 17) {
        break;
      }
    }
    newMac += mac.text;
  }

  @override
  void initState() {
    super.initState();
    print(widget.infostudent.accountNo);
    studentid.text = widget.infostudent.studentID.toString();
    studentname.text = widget.infostudent.fullName.toString();
    selectedDepartmentOption = widget.infostudent.department;
    selectedLevelOption = widget.infostudent.level;
    mac.text = widget.infostudent.macAddress;
    preformeMac();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Student_Provider>(context, listen: false);
    return Container(
      height: MediaQuery.of(context).size.height * 0.70,
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
              TextFieldStudentID(
                context,
                'Student ID',
                studentid,
              ),
              TextFieldStudentCustom(
                context,
                'Student Name',
                studentname,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                height: 50,
                width: MediaQuery.of(context).size.width * 0.20,
                child: DropdownButtonFormField<String>(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                  hint: Text(
                    'Department',
                  ),
                  value: selectedDepartmentOption,
                  onChanged: (String? newValue) {
                    selectedDepartmentOption = newValue;
                  },
                  items: departmentList.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  decoration: InputDecoration(
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
                margin: EdgeInsets.only(bottom: 5),
                height: 50,
                width: MediaQuery.of(context).size.width * 0.20,
                child: DropdownButtonFormField<String>(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                  hint: Text('Level'),
                  value: selectedLevelOption,
                  onChanged: (String? newValue) {
                    selectedLevelOption = newValue;
                  },
                  items: levelList.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      controller: cont1,
                      onTap: () {
                        if (newMac.length == 17) {
                          newMac = "";
                          cont1.clear();
                          cont2.clear();
                          cont3.clear();
                          cont4.clear();
                          cont5.clear();
                          cont6.clear();
                        }
                      },
                      onChanged: (value) {
                        if (value.length == 2) {
                          FocusScope.of(context).nextFocus();

                          newMac += cont1.text.toUpperCase();
                        }
                      },
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(2),
                        //  FilteringTextInputFormatter.singleLineFormatter
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      controller: cont2,
                      onTap: () {
                        if (newMac.length == 17) {
                          newMac = "";
                          cont1.clear();
                          cont2.clear();
                          cont3.clear();
                          cont4.clear();
                          cont5.clear();
                          cont6.clear();
                        }
                      },
                      onChanged: (value) {
                        if (value.length == 2) {
                          FocusScope.of(context).nextFocus();
                          newMac += ':' + cont2.text.toUpperCase();
                        }
                      },
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(2),
                        //      FilteringTextInputFormatter.singleLineFormatter
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      controller: cont3,
                      onTap: () {
                        if (newMac.length == 17) {
                          newMac = "";
                          cont1.clear();
                          cont2.clear();
                          cont3.clear();
                          cont4.clear();
                          cont5.clear();
                          cont6.clear();
                        }
                      },
                      onChanged: (value) {
                        if (value.length == 2) {
                          FocusScope.of(context).nextFocus();
                          newMac += ':' + cont3.text.toUpperCase();
                        }
                      },
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(2),
                        //   FilteringTextInputFormatter.
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      controller: cont4,
                      onTap: () {
                        if (newMac.length == 17) {
                          newMac = "";
                          cont1.clear();
                          cont2.clear();
                          cont3.clear();
                          cont4.clear();
                          cont5.clear();
                          cont6.clear();
                        }
                      },
                      onChanged: (value) {
                        if (value.length == 2) {
                          FocusScope.of(context).nextFocus();
                          newMac += ':' + cont2.text.toUpperCase();
                        }
                      },
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(2),
                        //   FilteringTextInputFormatter.singleLineFormatter
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      controller: cont5,
                      onTap: () {
                        if (newMac.length == 17) {
                          newMac = "";
                          cont1.clear();
                          cont2.clear();
                          cont3.clear();
                          cont4.clear();
                          cont5.clear();
                          cont6.clear();
                        }
                      },
                      onChanged: (value) {
                        if (value.length == 2) {
                          FocusScope.of(context).nextFocus();
                          newMac += ':' + cont5.text.toUpperCase();
                        }
                      },
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(2),
                        //       FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      controller: cont6,
                      onTap: () {
                        if (newMac.length == 17) {
                          newMac = "";
                          cont1.clear();
                          cont2.clear();
                          cont3.clear();
                          cont4.clear();
                          cont5.clear();
                          cont6.clear();
                        }
                      },
                      onChanged: (value) {
                        if (value.length == 2) {
                          FocusScope.of(context).nextFocus();
                          newMac += ':' + cont6.text.toUpperCase();
                        }
                      },
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(2),
                        //      FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Buttom_Edit(context, provider),
            ],
          )),
    );
  }

  Widget Buttom_Edit(BuildContext context, Student_Provider provider) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(style: BorderStyle.solid, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: MediaQuery.of(context).size.width * 0.09,
      height: MediaQuery.of(context).size.height * 0.06,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white)),
          onPressed: () {
            print(newMac);
            if (formstate.currentState!.validate()) {
              Navigator.pop(context);
              setState(() {
                provider.editStudent(
                    context,
                    studentname.text,
                    selectedDepartmentOption.toString(),
                    selectedLevelOption.toString(),
                    lastMac == "" ? newMac : lastMac,
                    studentid.text,
                    widget.infostudent.accountNo.toString());
              });
              studentid.clear();
              studentname.clear();
              selectedDepartmentOption;
              selectedLevelOption;
            }
          },
          child: Text(
            'Save',
            style: TextStyle(fontSize: 20, color: Colors.black),
          )),
    );
  }
}
