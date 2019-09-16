import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sd_agenda/models/task_data.dart';
import 'package:intl/intl.dart';

class PeriodField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final format = DateFormat("EEEE, d 'de' MMM, yyyy 'às' H:mm", 'pt');
    var dataProvider = Provider.of<TaskData>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Período',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.pink[700],
          ),
        ),
        DateTimeField(
          textAlign: TextAlign.center,
          format: format,
          readOnly: true,
          style: TextStyle(
            fontSize: 15.0,
          ),
          cursorColor: Colors.pink[700],
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: dataProvider.selectedDate,
              lastDate: DateTime(2100),
            );
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(dataProvider.selectedDate),
              );
              return dataProvider.dateTime = DateTimeField.combine(date, time);
            } else {
              //newDateTime = currentValue;
              return dataProvider.dateTime = currentValue;
            }
          },
        ),
      ],
    );
  }
}
