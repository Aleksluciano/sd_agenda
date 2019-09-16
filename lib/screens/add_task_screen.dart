import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sd_agenda/models/task_data.dart';
import 'package:sd_agenda/widgets/activitie_field.dart';
import 'package:sd_agenda/widgets/period_field.dart';
import 'package:sd_agenda/widgets/responsible_field.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<TaskData>(context);

    return Container(
      color: Color(0xff5c042c),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 25),
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ResponsibleField(),
                ActivitieField(),
                PeriodField(),
                FlatButton(
                  child: Text(
                    'Adicionar',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.pink[700],
                  onPressed: () {
                    final newTaskTitle = dataProvider.taskTitle;
                    final newDateTime = dataProvider.dateTime;
                    if (newDateTime != null && newTaskTitle != null) {
                      dataProvider.addTask();
                      dataProvider.selectedDate = newDateTime;
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
