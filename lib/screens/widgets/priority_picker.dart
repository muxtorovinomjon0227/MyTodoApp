import 'package:flutter/material.dart';
import 'package:up_todo/utils/colors.dart';

import '../../database/category.dart';

class PriorityPicker extends StatefulWidget {
  ValueChanged<int> onSelected;

  PriorityPicker({Key? key, required this.onSelected}) : super(key: key);

  @override
  State<PriorityPicker> createState() => _PriorityPickerState();
}

class _PriorityPickerState extends State<PriorityPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.height * 0.7,
      child: GridView.builder(
          itemCount: 10,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisSpacing: 4,
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return categoryItem(index + 1);
          }),
    );
  }

  Widget categoryItem(int index) {
    return InkWell(
      onTap: () {
        widget.onSelected(index);
        Navigator.pop(context);
      },
      child: Column(
        children: [
          Container(
            height: 64,
            width: 64,
            color: AppColors.C_272727,
            child: Center(
              child: Icon(
                Icons.flag_outlined,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 4),
          Expanded(
            child: Text(
              index.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
