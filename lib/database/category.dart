class TodoCategory {
  String name;
  int iconCode;

  TodoCategory({
    required this.name,
    required this.iconCode,
  });

  static List<TodoCategory> categories = [
    TodoCategory(name: "Grocery", iconCode: 0xeef3),
    TodoCategory(name: "Work", iconCode: 0xf4d4),
    TodoCategory(name: "Sport", iconCode: 0xf3c7),
    TodoCategory(name: "Design", iconCode: 0xe1c0),
    TodoCategory(name: "University", iconCode: 0xe1c0),
    TodoCategory(name: "Social", iconCode: 0xe1c0),
  ];
}
