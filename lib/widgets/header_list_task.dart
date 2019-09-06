import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sd_agenda/models/task_data.dart';
import 'package:sd_agenda/screens/login_screen.dart';


class HeaderListTask extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0, bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text("2019 \u00a9 Author's Alex Avelar"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CircleAvatar(
                child: Image(
                  image: AssetImage('images/calendar.png'),
                ),
              ),
              FlatButton(
                color: Colors.white,
                onPressed: () {
                  _auth.signOut();
               Navigator.pushReplacementNamed(context, LoginScreen.id);
                },
                child: Text('Sair'),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'SD agenda',
            style: TextStyle(
              color: Colors.white,
              fontSize: 50.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'Lobster',
            ),
          ),
          Text(
            '${Provider.of<TaskData>(context).taskCountDone} Atividades',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
