import 'package:flutter/material.dart';
import 'package:up_todo/screens/screen_3.dart';

class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Screen 2",
          style: TextStyle(fontSize: 32),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Screen3()),
          );
        },
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
