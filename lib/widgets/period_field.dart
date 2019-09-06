import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sd_agenda/models/task_data.dart';
import 'package:intl/intl.dart';

class PeriodField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final format = DateFormat("EEEE, d 'de' MMM, yyyy 'às' H:mm", 'pt');

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
              initialDate: Provider.of<TaskData>(context).selectedDate,
              lastDate: DateTime(2100),
            );
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(Provider.of<TaskData>(context).selectedDate),
              );
              return Provider.of<TaskData>(context).dateTime =
                  DateTimeField.combine(date, time);
            } else {
              //newDateTime = currentValue;
              return Provider.of<TaskData>(context).dateTime = currentValue;
            }
          },
        ),
      ],
    );
  }
}
