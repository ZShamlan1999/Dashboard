import 'package:flutter/material.dart';

import '../../constent/constant.dart';
class LoginButton extends StatelessWidget {
  final String buttonName;
  final Function() onPress;

  const LoginButton(
      {super.key, required this.buttonName, required this.onPress});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: 40,
      child: ElevatedButton(
        
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kPrimaryColor)),
        onPressed: onPress,
        child: Text(
          buttonName,
          style: TextStyle(fontSize: fontSize25, fontFamily: 'Lexend'),
        ),
      ),
    );
  }
}
