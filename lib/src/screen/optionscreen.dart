import 'package:flutter/material.dart';

class OptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            IconButton(
                alignment: Alignment.topLeft,
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Text(
              "Cài Đặt ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
