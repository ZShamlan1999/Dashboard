 import 'package:flutter/material.dart';

Widget AlertToDelete(BuildContext context, Function() onDelete) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Are your sure delete this account ?'),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: onDelete, child: Text('Ok')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'))
          ],
        )
      ]),
    );
  }
