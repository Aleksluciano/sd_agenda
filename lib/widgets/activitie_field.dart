import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sd_agenda/models/task_data.dart';

class ActivitieField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<TaskData>(context);
    return Column(
      children: <Widget>[
        Text(
          'Atividade',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.pink[700],
          ),
        ),
        TextField(
          autofocus: true,
          textAlign: TextAlign.center,
          cursorColor: Colors.pink[700],
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.pink[700]),
            ),
          ),
          style: TextStyle(fontSize: 15),
          onChanged: (newText) {
            dataProvider.taskTitle = newText;
          },
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
