import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_todo/screens/widgets/task_item.dart';
import 'package:up_todo/screens/widgets/update_task_widget.dart';

import '../database/local_database.dart';
import '../models/todo_model.dart';
import '../theme_provider.dart';
import '../utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search = '';
  int countOfCompleted = 0;
  int countOfUncompleted = 0;

  @override
  Widget build(BuildContext context) {
    var isLight = context.watch<ThemeProvider>().getIsLight();

    return Scaffold(
      backgroundColor: isLight ? Colors.white : Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            searchTodo(),
            todayTodos(),
            completedTodos(),
          ],
        ),
      ),
    );
  }

  Widget searchTodo() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        onChanged: (val) {
          setState(() {
            search = val;
          });
        },
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
          filled: true,
          fillColor: AppColors.C_363636.withOpacity(0.5),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
          )),
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.red,
          )),
        ),
      ),
    );
  }

  Widget todayTodos() {
    return ExpansionTile(
      initiallyExpanded: true,
      iconColor: Colors.white,
      title: Text(
        'Uncompleted'.tr(),
        style: TextStyle(color: Colors.white),
      ),
      children: [
        SingleChildScrollView(
          child: FutureBuilder(
            future: LocalDatabase.getTodosIsCompleted(0, title: search),
            builder: (BuildContext context,
                AsyncSnapshot<List<TodoModel>> snapshot) {
              if (snapshot.hasData) {
                countOfUncompleted = snapshot.data!.length;
                if (snapshot.data!.isEmpty) {
                  return const Center(
                      child: Icon(
                    Icons.file_copy_outlined,
                    color: Colors.white,
                    size: 96,
                  ));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return TaskItem(
                      onCompleted: (todo) {
                        setState(() {
                          LocalDatabase.updateTaskById(
                            todo.copyWith(isCompleted: 1),
                          );
                        });
                      },
                      model: snapshot.data![index],
                      onDeleted: () {
                        setState(() {});
                      },
                      onSelected: () {
                        showModalBottomSheet(
                          backgroundColor: AppColors.C_363636,
                          context: context,
                          builder: (context) {
                            return UpdateTaskWidget(
                              todo: snapshot.data![index],
                              onUpdatedTask: () {
                                setState(() {});
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }

  Widget completedTodos() {
    return ExpansionTile(
      initiallyExpanded: true,
      iconColor: Colors.white,
      title: Text(
        'Completed'.tr(),
        style: TextStyle(color: Colors.white),
      ),
      children: [
        FutureBuilder(
          future: LocalDatabase.getTodosIsCompleted(1, title: search),
          builder:
              (BuildContext context, AsyncSnapshot<List<TodoModel>> snapshot) {
            if (snapshot.hasData) {
              countOfCompleted = snapshot.data!.length;
              if (snapshot.data!.isEmpty) {
                return const Center(
                    child: Icon(
                  Icons.file_copy_outlined,
                  color: Colors.white,
                  size: 96,
                ));
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskItem(
                    model: snapshot.data![index],
                    onCompleted: (todo) {
                      setState(() {
                        LocalDatabase.updateTaskById(
                          todo.copyWith(isCompleted: 0),
                        );
                      });
                    },
                    onDeleted: () {
                      setState(() {});
                    },
                    onSelected: () {
                      showModalBottomSheet(
                        backgroundColor: AppColors.C_363636,
                        context: context,
                        builder: (context) {
                          return UpdateTaskWidget(
                            todo: snapshot.data![index],
                            onUpdatedTask: () {
                              setState(() {});
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}
