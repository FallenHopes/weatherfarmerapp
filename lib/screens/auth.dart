import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherfarmer/services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final srvc = context.watch<AuthService>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Farmer Weather"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 80, left: 40, right: 40, bottom: 50),
            child: Column(
              children: <Container>[
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Здравствуй, фермер!",
                    style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  child: Text(
                    "Данное приложение предназначено для того, чтобы помочь тебе в проведении полевых работ и создании агрономических отчётов",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: <Container>[
                Container(
                  margin: EdgeInsets.only(bottom: 25),
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Email / Логин",
                    ),
                    onChanged: (val){
                      setState((){
                        email = val;
                      });
                    },
                  ),
                ),
                Container(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Пароль",
                    ),
                    obscureText: true,
                    onChanged: (val){
                      setState((){
                        password = val;
                      });
                    },
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: 60),
                  height: 50,
                  width: 300,
                  child: RaisedButton(
                    elevation: 2,
                    child: Text(
                      "Войти",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                      )
                    ),
                    color: Theme.of(context).primaryColor,
                    splashColor: Colors.lightGreen,
                    onPressed: (){
                      if (email.isEmpty || password.isEmpty) return;
                      srvc.login(email, password);
                    },
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}