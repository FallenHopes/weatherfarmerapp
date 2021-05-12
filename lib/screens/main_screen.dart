import 'package:flutter/material.dart';
import 'package:weatherfarmer/components/left_drawer.dart';
import 'package:provider/provider.dart';
import 'package:weatherfarmer/services/auth_service.dart';
import 'package:weatherfarmer/services/reports_service.dart';
import '../services/notifications_service.dart';
import 'list_selector.dart';

class MainScreen extends StatefulWidget {
  String token;
  MainScreen({@required this.token});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int screenIdx = 0;
  NotificationsService ntfcs = NotificationsService();
  ReportsService rpts = ReportsService();
  void screenChanger(int screen){
    setState((){
      screenIdx = screen;
    });
  }
  @override
  void initState(){
    ntfcs.getNotificationsFromServer(widget.token);
    rpts.getReportsFromLocalStorage();
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider<NotificationsService>.value(
      value: ntfcs,
      child: ChangeNotifierProvider<ReportsService>.value(
        value: rpts,
        child: Scaffold(
          appBar: AppBar(
            title: screenIdx == 0 ? Text('Уведомления') : Text('Отчёты')
          ),
          drawer: LeftPanel(screenChanger: screenChanger),
          body: ListSelector(screen: screenIdx)
        )
      )
    );
  }
}