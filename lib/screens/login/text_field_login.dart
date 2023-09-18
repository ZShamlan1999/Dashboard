import 'package:flutter/material.dart';

class TextFormLogin extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController myController;
  final bool obscureText;
  final Widget icon;
  const TextFormLogin(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.myController,
      this.obscureText = false, required this.icon});

  @override
  State<TextFormLogin> createState() => _TextFormLoginState();
}

class _TextFormLoginState extends State<TextFormLogin> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.045,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: TextFormField(
          controller: widget.myController,
          obscureText: widget.obscureText,
          
          validator: (value) {
            if (value!.isEmpty) {
              return 'Required';
            }
            return null;
          },
          decoration: InputDecoration(
              label: Text(widget.labelText),
              suffixIcon: widget.icon,
              contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)))),
        ),
      ),
    );
  }
}
