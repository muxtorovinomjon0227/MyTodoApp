import 'package:flutter/material.dart';
import 'package:up_todo/utils/colors.dart';

import '../../database/category.dart';

class CategoryPicker extends StatefulWidget {
  ValueChanged<int> onSelected;

  CategoryPicker({Key? key, required this.onSelected}) : super(key: key);

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.height * 0.7,
      child: GridView.builder(
          itemCount: TodoCategory.categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisSpacing: 4,
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return categoryItem(TodoCategory.categories[index], index);
          }),
    );
  }

  Widget categoryItem(TodoCategory category, int index) {
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
            color: Colors.green,
            child: Center(
              child: Icon(
                IconData(category.iconCode, fontFamily: 'MaterialIcons'),
                size: 32,
              ),
            ),
          ),
          SizedBox(height: 4),
          Expanded(
            child: Text(
              category.name,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
