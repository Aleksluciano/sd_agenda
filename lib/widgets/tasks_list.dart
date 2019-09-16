import 'package:flutter/material.dart';
//import 'package:sd_agenda/models/task.dart';
import 'package:sd_agenda/widgets/task_tile.dart';
import 'package:provider/provider.dart';
import 'package:sd_agenda/models/task_data.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<TaskData>(context);
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
            padding: EdgeInsets.only(bottom: 70, top: 10),
            itemBuilder: (context, index) {
              final task = taskData.tasks[index];
              return TaskTile(
                  taskPerson: task.person,
                  taskTitle: task.name,
                  taskDateTime: task.dateTime,
                  isChecked: task.isDone,
                  index: index,
                  checkboxCallback: (checkboxState) {
                    taskData.updateTask(task);
                  },
                  longPressCallback: () {
                    // flutter defined function
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          title: new Text("Confirmação!"),
                          content: new Text("Quer mesmo remover a atividade?"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Não"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text("Sim"),
                              onPressed: () {
                                taskData.deleteTask(task);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  });
            },
            itemCount: dataProvider.taskCount);
      },
    );
  }
}
