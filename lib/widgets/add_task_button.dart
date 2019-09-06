import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sd_agenda/models/task_data.dart';
import 'package:sd_agenda/screens/add_task_screen.dart';

class AddTaskButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.pink[700],
      child: Icon(Icons.add),
      onPressed: () {
          Provider.of<TaskData>(context).taskTitle = null;
          Provider.of<TaskData>(context).dateTime  = null;
        var keyboardHigh = 0.00;
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            if(keyboardHigh < MediaQuery.of(context).viewInsets.bottom)
        keyboardHigh = MediaQuery.of(context).viewInsets.bottom;
          return AddTaskScreen();},
        );
      },
    );
  }
}