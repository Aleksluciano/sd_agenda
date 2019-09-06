import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sd_agenda/models/task_data.dart';

class DateListTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 20),
            //margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
              color: Color(0xff6b56a5),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: GestureDetector(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: Provider.of<TaskData>(context).selectedDate,
                    lastDate: DateTime(2100),
                    selectableDayPredicate: (DateTime day) {
                      // print(day);
                      return Provider.of<TaskData>(context)
                          .verifyAppointmentInDay(day);
                    },
                  );

                  if (date != null) {
                    Provider.of<TaskData>(context).selectedDate = date;
                  }
                },
                child: Text(
                  '🔍 ' +
                      DateFormat("EEE, d 'de' MMM, yyyy", 'pt')
                          .format(Provider.of<TaskData>(context).selectedDate),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
