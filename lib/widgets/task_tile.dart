import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final String taskPerson;
  final DateTime taskDateTime;
  final Function checkboxCallback;
  final Function longPressCallback;
  final int index;

  TaskTile(
      {this.taskPerson,
      this.taskTitle,
      this.taskDateTime,
      this.isChecked,
      this.index,
      this.checkboxCallback,
      this.longPressCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Chip(
          label: Text(
            DateFormat('HH:mm').format(taskDateTime),
            style: TextStyle(
              fontSize: 20,
              fontWeight: isChecked ? FontWeight.w300 : FontWeight.w600,
              decoration: isChecked ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ),
      onLongPress: longPressCallback,
      subtitle: Text(
        taskPerson,
      ),
      title: Text(
        taskTitle,
        style: TextStyle(
            fontWeight: isChecked ? FontWeight.w300 : FontWeight.w400,
            fontSize: 17,
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Padding(
        padding: EdgeInsets.only(bottom: 25),
        child: Checkbox(
          activeColor: Color(0xff6b56a5),
          value: isChecked,
          onChanged: checkboxCallback,
        ),
      ),
    );
  }
}
