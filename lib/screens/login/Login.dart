import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dashboard_esmani/constent/constant.dart';
import 'package:dashboard_esmani/constent/crud.dart';
import 'package:dashboard_esmani/constent/linkapi.dart';
import 'package:dashboard_esmani/main.dart';
import 'package:flutter/material.dart';
import 'button_login.dart';
import 'text_field_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
Crud crud = Crud();
  loginAdmin() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(linkLoginAdmin, {
        'username': username.text,
        'password': password.text,
      }, {});
      isLoading = false;
      setState(() {});
      if (response['status'] == "Success") {
        print('=========================');
        print(response['data']);
        sharedpref.setString('id', response['data']['ID'].toString());
        sharedpref.setString('admin_name', response['data']['name']);
        sharedpref.setString('user_name', response['data']['username']);
        sharedpref.setString('password', response['data']['password']);

        Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
      } else {
        AwesomeDialog(
            width: 450,
            headerAnimationLoop: true,
            context: context,
            btnCancel: Icon(Icons.cancel),
            title: 'Worring!',
            body: Text('User Name Or Passwrod wrong Or is does not found'))
          ..show();
      }
    }
  }

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(flex: 2, child: Left_Side()),
          Expanded(
            flex: 3,
            child: isLoading == true
                ? Center(child: CircularProgressIndicator())
                : Form(
                    key: formstate,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: fontSize30, fontFamily: 'Lexend'),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormLogin(
                            labelText: 'User Name',
                            hintText: 'Enter User Name',
                            icon: Icon(Icons.person),
                            myController: username),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormLogin(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            obscureText: _obscureText,
                            icon: IconButton(
                              icon: Icon(_obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            myController: password),
                        SizedBox(
                          height: 25,
                        ),
                        LoginButton(
                          buttonName: 'Login',
                          onPress: () async {
                            await loginAdmin();
                          },
                        )
                      ],
                    )),
          )
        ],
      ),
    );
  }

  Container Left_Side() {
    return Container(
      color: kPrimaryColor,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 60,
          width: 60,
          child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
        ),
        Text(
          'ESMANI',
          style: TextStyle(
              fontSize: fontSize40, color: Colors.white, fontFamily: 'Lexend'),
        )
      ]),
    );
  }
}
