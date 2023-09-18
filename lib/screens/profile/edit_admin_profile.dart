import 'package:dashboard_esmani/constent/linkapi.dart';
import 'package:dashboard_esmani/screens/student/widget/textfieldcoustom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constent/constant.dart';
import '../../constent/crud.dart';
import '../../main.dart';
import '../../provider/provider.dart';

class EditAdminProfile extends StatefulWidget {
  final infoAdmin;
  EditAdminProfile({super.key, this.infoAdmin});

  @override
  State<EditAdminProfile> createState() => _EditAdminProfileState();
}

class _EditAdminProfileState extends State<EditAdminProfile>  {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  void initState() {
    name.text = sharedpref.getString('admin_name').toString();
    password.text = sharedpref.getString('password').toString();
    super.initState();
  }


  Crud crud = Crud();

  editAdmin() async {
    var response = await crud.postRequest(linkLEditAdmin, {
      'name': name.text,
      'password': password.text,
      'id': sharedpref.getString('id')
    }, {});
    if (response['status'] == "Success") {
      sharedpref.setString('admin_name', name.text);
    } else {
      print('ErrrrOR');
    }
  }

  bool _obscureText = true;
  bool _obscureText2 = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black87,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xffeaeaea),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: EdgeInsets.only(top: 10, right: 10, bottom: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Header(context),
              ),
              SizedBox(
                height: 60,
              ),
              Form(
                key: formstate,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  context
                                      .read<MyProvider>()
                                      .changeCurentPageIndex(3);
                                },
                                icon: Icon(Icons.cancel))
                          ],
                        ),
                        CirclerAvatar(),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name : '),
                              TextFieldAdminCustomName(
                                context,
                                Icon(Icons.person),
                                name,
                              ),
                              Text('Password : '),
                              TextFieldAdminCustomPass(
                                  context,
                                  IconButton(
                                    icon: Icon(_obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                  password,
                                  _obscureText),
                              Text('Confirm Password : '),
                              TextFieldAdminCustomConfPass(
                                context,
                                IconButton(
                                  icon: Icon(_obscureText2
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText2 = !_obscureText2;
                                    });
                                  },
                                ),
                                confirmPassword,
                                _obscureText2,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SaveButton(context)
                            ],
                          ),
                        )
                      ]),
                ),
              )
            ],
          ),
        ));
  }

  Widget SaveButton(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(kPrimaryColor)),
          onPressed: () {
            if (formstate.currentState!.validate()) {
              editAdmin();
              context.read<MyProvider>().changeCurentPageIndex(0);
            }
          },
          child: Text('Save')),
    );
  }

  Widget CirclerAvatar() {
    return CircleAvatar(
      backgroundColor: kPrimaryColor,
      radius: 30,
      child: Icon(
        Icons.person,
        size: 40,
        color: Colors.white,
      ),
    );
  }

  Widget ProfileText(String text) {
    return Text(
      text,
      style: TextStyle(color: Color(0xff000000), fontSize: 18),
    );
  }

  Widget Header(BuildContext context) {
    return Row(
      children: [
        Text(
          'Profile',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w400,
            letterSpacing: 2,
          ),
        ),
        Spacer(
          flex: 2,
        ),
      ],
    );
  }

  Widget TextFieldAdminCustomPass(
    BuildContext context,
    Widget icon,
    TextEditingController myController,
    bool obscure,
  ) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.048,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.20,
        child: TextFormField(
          controller: myController,
          obscureText: obscure,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Required';
            }
            if (value.length < 5) {
              return 'Password must be grater than 5';
            }
            if (value.length == ' ') {
              return 'Enter Text';
            }
            return null;
          },
          decoration: InputDecoration(
              suffixIcon: icon,
              contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              hintStyle: TextStyle(fontSize: 12),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        ),
      ),
    );
  }

  Widget TextFieldAdminCustomConfPass(
    BuildContext context,
    Widget icon,
    TextEditingController myController,
    bool obscure,
  ) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.048,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.20,
        child: TextFormField(
          controller: myController,
          obscureText: obscure,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Required';
            }

            if (password.text != confirmPassword.text) {
              return 'Password Wrong';
            }
            return null;
          },
          decoration: InputDecoration(
              suffixIcon: icon,
              contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              hintStyle: TextStyle(fontSize: 12),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        ),
      ),
    );
  }
}
