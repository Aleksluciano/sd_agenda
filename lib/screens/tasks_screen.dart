import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sd_agenda/models/task_data.dart';
import 'package:sd_agenda/widgets/add_task_button.dart';
import 'package:sd_agenda/widgets/date_list_task.dart';
import 'package:sd_agenda/widgets/header_list_task.dart';
import 'package:sd_agenda/widgets/list_tasks.dart';

class TasksScreen extends StatefulWidget {
  static const String id = 'tasks_screen';

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        var dataProvider = Provider.of<TaskData>(context);
        loggedInUser = user;
        print(loggedInUser.email);
        dataProvider.fetchStreamData();
        dataProvider.selectedDate = DateTime.now();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //initializeDateFormatting('pt', null).then((_) {
    return Scaffold(
      backgroundColor: Colors.pink[700],
      floatingActionButton: AddTaskButton(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderListTask(),
          DateListTask(),
          ListTasks(),
        ],
      ),
    );
  }
}
