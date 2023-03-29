import 'package:flutter/material.dart';
import 'package:up_todo/screens/home_page.dart';
import 'package:up_todo/screens/main_page.dart';

class Screen3 extends StatelessWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Screen 3",
          style: TextStyle(fontSize: 32),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => MainPage()),
            (route) => false,
          );
        },
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
