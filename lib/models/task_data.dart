import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sd_agenda/models/task.dart';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskData extends ChangeNotifier {
 final _firestore = Firestore.instance;

  String _person = 'Carla';
  DateTime dateTime;
  DateTime _selectedDate = DateTime.now();
  String taskTitle;
  bool mustWaitToSwip = false;
  List<Task> _tasks = [];


 fetchStreamData() async {
    
    await for (var snapshot in _firestore.collection('agenda').snapshots()){
      _tasks = [];
      for (var agenda in snapshot.documents){
         
        _tasks.add( Task(person: agenda.data['person'], name: agenda.data['name'], dateTime: DateTime.fromMillisecondsSinceEpoch(agenda.data['dateTime'].seconds * 1000), isDone: agenda.data['isDone'] != null ? agenda.data['isDone'] : false, id: agenda.documentID));
      }
       notifyListeners();
 
    }   

   
     
  } 

  UnmodifiableListView<Task> get tasks {
    _tasks.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    final dayTasks =
        _tasks.where((a) => a.dateTime.day == _selectedDate.day).toList();
    return UnmodifiableListView(dayTasks);
  }

  void nextDate() {
    if (!mustWaitToSwip) {
      waitSwipProcess();
      final nextDay = _tasks.firstWhere((a) {
        var actualDay = a.dateTime;
        var comparation =
            DateTime.utc(actualDay.year, actualDay.month, actualDay.day)
                .compareTo(_selectedDate);
        return comparation == 1;
      }, orElse: () => null);

      if (nextDay != null) selectedDate = nextDay.dateTime;
    }
  }

  void previousDate() {
    if (!mustWaitToSwip) {
      waitSwipProcess();
      final previousDay = _tasks.reversed.firstWhere((a) {
        var actualDay = a.dateTime;
        var comparation =
            DateTime.utc(actualDay.year, actualDay.month, actualDay.day)
                .compareTo(_selectedDate);
        return comparation == -1;
      }, orElse: () => null);
      if (previousDay != null) selectedDate = previousDay.dateTime;
    }
  }

  void waitSwipProcess() {
    mustWaitToSwip = true;
    Future.delayed(Duration(milliseconds: 400), () {
      mustWaitToSwip = false;
    });
  }

  set selectedDate(DateTime newDate) {
    _selectedDate = DateTime.utc(newDate.year, newDate.month, newDate.day);
    notifyListeners();
  }

  DateTime get selectedDate {
    return _selectedDate;
  }

  set person(String newPerson) {
    _person = newPerson;
    notifyListeners();
  }

  String get person {
    return _person;
  }

  int get taskCountDone {
    return _tasks.where((a) => !a.isDone).length;
  }

  int get taskCount {
    return _tasks.where((a) {
      var actualDay = a.dateTime;
      var comparation =
          DateTime.utc(actualDay.year, actualDay.month, actualDay.day)
              .compareTo(_selectedDate);
      return comparation == 0;
    }).length;
  }

  bool verifyAppointmentInDay(DateTime day) {
    final today = DateTime.utc(
        DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final isToday = DateTime.utc(day.year, day.month, day.day).compareTo(today);
    if (isToday == 0) return true;

    final calendarDay = DateTime.utc(day.year, day.month, day.day);
    final activitie = _tasks.firstWhere((a) {
      var actualDay = a.dateTime;
      var comparation =
          DateTime.utc(actualDay.year, actualDay.month, actualDay.day)
              .compareTo(calendarDay);
      return comparation == 0;
    }, orElse: () => null);

    return activitie != null;

  }

  void addTask() {
    _firestore.collection("agenda").add({'person': _person, 'name': taskTitle, 'dateTime': dateTime, 'isDone': false });
  }

  void updateTask(Task task) {
    task.toggleDone();
    _firestore.collection('agenda').document(task.id).updateData({ 'isDone': task.isDone });
  }

  void deleteTask(Task task) {
    _firestore.collection('agenda').document(task.id).delete();
  }
}
