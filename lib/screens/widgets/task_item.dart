import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:up_todo/database/category.dart';
import 'package:up_todo/database/local_database.dart';
import 'package:up_todo/utils/colors.dart';
import 'package:up_todo/utils/time_utils.dart';

import '../../models/todo_model.dart';

class TaskItem extends StatelessWidget {
  TodoModel model;
  final VoidCallback onDeleted;
  final VoidCallback onSelected;
  final ValueChanged<TodoModel> onCompleted;

  TaskItem({
    Key? key,
    required this.model,
    required this.onDeleted,
    required this.onSelected,
    required this.onCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.C_363636,
          borderRadius: BorderRadius.circular(9),
        ),
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                onCompleted(model);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: model.isCompleted == 1
                        ? Colors.green
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    )),
                height: 20,
                width: 20,
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  model.title.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(height: 8),
                    model.date != "null"
                        ? Text(
                            TimeUtils.formatToMyTime(
                                DateTime.parse(model.date)),
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          )
                        : Text(""),
                    const SizedBox(width: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        taskCategoryItem(model.categoryId),
                        const SizedBox(width: 8),
                        taskPriorityItem(model.priority)
                      ],
                    )
                  ],
                )
              ],
            ),
            // IconButton(
            //     onPressed: () {
            //       showDialog(
            //           context: context,
            //           builder: (context) {
            //             return AlertDialog(
            //               title: Text("Delete"),
            //               content: Text(
            //                 "Are you sure to delete task ${model.title}",
            //               ),
            //               actions: [
            //                 TextButton(
            //                   onPressed: () {},
            //                   child: Text("NO"),
            //                 ),
            //                 TextButton(
            //                   onPressed: () async {
            //                     var res = await LocalDatabase.deleteTaskById(
            //                         model.id!);
            //                     if (res != 0) {
            //                       Navigator.pop(context);
            //                       onDeleted();
            //                     }
            //                   },
            //                   child: Text("YES"),
            //                 ),
            //               ],
            //             );
            //           });
            //     },
            //     icon: const Icon(
            //       Icons.delete_forever,
            //       color: Colors.red,
            //       size: 28,
            //     ))
          ],
        ),
      ),
    );
  }

  Widget taskCategoryItem(int categoryIndex) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.green,
      ),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              IconData(
                TodoCategory.categories[categoryIndex].iconCode,
                fontFamily: 'MaterialIcons',
              ),
              color: Colors.white.withOpacity(0.9),
            ),
            const SizedBox(width: 4),
            Text(
              TodoCategory.categories[categoryIndex].name,
              style: TextStyle(color: Colors.white.withOpacity(0.9)),
            ),
          ],
        ),
      ),
    );
  }

  Widget taskPriorityItem(int priority) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(
        color: AppColors.C_8687E7,
        width: 2,
      )),
      child: Row(
        children: [
          Icon(
            Icons.flag_outlined,
            color: Colors.white,
          ),
          SizedBox(width: 4),
          Text(
            priority.toString(),
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
