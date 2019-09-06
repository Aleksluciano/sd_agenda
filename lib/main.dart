import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sd_agenda/screens/tasks_screen.dart';
import 'package:provider/provider.dart';
import 'package:sd_agenda/models/task_data.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:sd_agenda/screens/login_screen.dart';

bool userConnected = false;

void main() async {
  final _auth = FirebaseAuth.instance;
  final user = await _auth.currentUser();
  if (user != null) {
    userConnected = true;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String id = 'tasks_screen';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return ChangeNotifierProvider(
      builder: (context) => TaskData(),
      child: MaterialApp(
        localizationsDelegates: [
          //GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('pt', 'BR'),
        ],
        initialRoute: userConnected ? TasksScreen.id : LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          TasksScreen.id: (context) {
            return Theme(
              data: ThemeData(
                primaryColor: Colors.pink[700],
                buttonColor: Colors.pink[700],
                accentColor: Colors.pink[400],
              ),
              child: TasksScreen(),
            );
          },
        },
      ),
    );
  }
}
