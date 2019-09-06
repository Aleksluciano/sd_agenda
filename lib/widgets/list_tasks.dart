import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sd_agenda/models/task_data.dart';
import 'package:sd_agenda/widgets/tasks_list.dart';

class ListTasks extends StatelessWidget {

 
  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx < 0) {
            Provider.of<TaskData>(context).nextDate();
          }
          if (details.delta.dx > 0) {
            Provider.of<TaskData>(context).previousDate();
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: TasksList(),
        ),
      ),
    );
  }
}
