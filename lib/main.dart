import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherfarmer/screens/auth.dart';
import 'package:weatherfarmer/screens/main_screen.dart';
import 'package:weatherfarmer/services/auth_service.dart';

void main() => runApp(WeatherFarmer());

class WeatherFarmer extends StatefulWidget {
  @override
  _WeatherFarmerState createState() => _WeatherFarmerState();
}

class _WeatherFarmerState extends State<WeatherFarmer> {
  SharedPreferences localStorage;
  AuthService authService;
  void getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      localStorage = prefs;
      authService = AuthService(localStorage: prefs);
      authService.checkLogin();
    });
  }
  @override
  void initState(){
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: localStorage, 
      child: ChangeNotifierProvider<AuthService>.value(
        value: authService,
        child: MaterialApp(
          title: 'Weather Farmer',
          theme: ThemeData(
            primaryColor: Color.fromRGBO(85, 139, 47, 1)
          ),
          home: localStorage != null ? DefaultPages() : Scaffold(
            body: Container(
              alignment: Alignment.center,
              child: Text("Загрузка...")
            )
          ),
        ),
      ),
    );
  }
}

class DefaultPages extends StatelessWidget{
  @override
  Widget build(BuildContext context) {    
    return context.watch<AuthService>().authToken != null ? MainScreen() : AuthScreen();
  }
}