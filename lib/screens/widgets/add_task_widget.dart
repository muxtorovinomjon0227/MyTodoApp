import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:up_todo/screens/widgets/category_picker.dart';
import 'package:up_todo/screens/widgets/priority_picker.dart';
import 'package:up_todo/utils/colors.dart';
import 'package:up_todo/utils/time_utils.dart';

import '../../database/category.dart';
import '../../database/local_database.dart';
import '../../models/todo_model.dart';

class AddTaskWidget extends StatefulWidget {
  VoidCallback onNewTask;

  AddTaskWidget({Key? key, required this.onNewTask}) : super(key: key);

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  final formKey = GlobalKey<FormState>();
  String newTitle = "";
  String newDescription = "";
  DateTime? taskDay = DateTime.now(); // 02.11.2022 ----
  TimeOfDay? taskTime; // ---------- 21:25
  int categoryId = 0; // ---------- 21:25
  int priority = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              style: TextStyle(color: Colors.white),
              onSaved: (val) {
                newTitle = val ?? "";
              },
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              style: TextStyle(color: Colors.white),
              onSaved: (val) {
                newDescription = val ?? "";
              },
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: TextFormField(
                      key: Key(taskDay.toString()),
                      style: TextStyle(color: Colors.white),
                      initialValue: TimeUtils.formatToMyTime(taskDay!),
                      readOnly: true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            taskDay = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2300),
                            );
                            taskTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            taskDay = DateTime(
                              taskDay!.year,
                              taskDay!.month,
                              taskDay!.day,
                              taskTime!.hour,
                              taskTime!.minute,
                            );
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                          ),
                        ),
                        hintText: 'Date',
                        hintStyle:
                            TextStyle(color: Colors.white.withOpacity(0.5)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    key: Key(TodoCategory.categories[categoryId].name),
                    style: TextStyle(color: Colors.white),
                    initialValue: TodoCategory.categories[categoryId].name,
                    readOnly: true,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: AppColors.C_363636,
                                content: CategoryPicker(
                                  onSelected: (index) {
                                    categoryId = index;
                                    setState(() {});
                                  },
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.label,
                            color: Colors.white,
                          )),
                      hintText: 'Category',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.5)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: TextFormField(
                key: Key(priority.toString()),
                style: TextStyle(color: Colors.white),
                initialValue: priority.toString(),
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: AppColors.C_363636,
                            content: PriorityPicker(
                              onSelected: (index) {
                                setState(() {
                                  priority = index;
                                });
                              },
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.flag,
                        color: Colors.white,
                      )),
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), minimumSize: Size(80, 80)),
                  onPressed: () {
                    formKey.currentState?.save();
                    if (newTitle.isNotEmpty &&
                        newDescription.isNotEmpty &&
                        taskDay != null &&
                        categoryId != -1) {
                      var newTodo = TodoModel(
                        title: newTitle,
                        description: newDescription,
                        date: taskDay.toString(),
                        categoryId: categoryId,
                        priority: priority,
                        isCompleted: 0,
                      );
                      LocalDatabase.insertToDatabase(newTodo);
                      widget.onNewTask();
                      Navigator.pop(context);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Oshibka qildin"),
                          content: Text("Hamasn toldrin"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Chundm"),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  child: Text("Add")),
            )
          ],
        ),
      ),
    );
  }
}
