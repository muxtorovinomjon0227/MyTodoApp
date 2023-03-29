import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // Container(
          //   child: Shimmer.fromColors(
          //     period: Duration(seconds: 2),
          //     enabled: true,
          //     child: Container(
          //       color: Colors.white,
          //       height: 200,
          //       width: double.infinity,
          //     ),
          //     baseColor: Colors.grey[500]!,
          //     highlightColor: Colors.grey[100]!,
          //   ),
          // ),
          SizedBox(
            width: 200.0,
            height: 100.0,
            child: Shimmer.fromColors(
              baseColor: Colors.red,
              highlightColor: Colors.yellow,
              child: Text(
                'Shimmer',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
