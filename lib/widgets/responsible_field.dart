import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sd_agenda/models/task_data.dart';

class ResponsibleField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> items = ['Carla', 'Paty', 'Bia'];
    var dataProvider = Provider.of<TaskData>(context);
    return Column(children: <Widget>[
      Text(
        'Responsável',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 17.0,
          color: Colors.pink[700],
        ),
      ),
      Center(
        child: DropdownButton<String>(
          elevation: 5,
          icon: Icon(Icons.person),
          value: dataProvider.person,
          onChanged: (String newValue) {
            dataProvider.person = newValue;
          },
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(fontSize: 15),
              ),
            );
          }).toList(),
        ),
      )
    ]);
  }
}
