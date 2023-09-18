import 'package:dashboard_esmani/constent/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? name;
  @override
  void initState() {
    super.initState();
    name = sharedpref.getString('admin_name');
  }

  bool _obscureText = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  height: MediaQuery.of(context).size.height * 0.45,
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
                                      .changeCurentPageIndex(4);
                                },
                                icon: Icon(Icons.edit))
                          ],
                        ),
                        CirclerAvatar(),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ProfileText('User Name : '),
                                  ProfileText(name!)
                                ],
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Row(
                                children: [
                                  ProfileText('Password : '),
                                  ProfileText(
                                    _obscureText
                                        ? sharedpref
                                            .getString('password')
                                            .toString()
                                        : "*******",
                                  ),
                                  Spacer(),
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
                                ],
                              ),
                            ],
                          ),
                        )
                      ]),
                )
              ],
            ),
          )),
    );
  }

  Widget CirclerAvatar() {
    return CircleAvatar(
      backgroundColor: kPrimaryColor,
      radius: 40,
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
}
