import 'package:flutter/material.dart';
import '../components/notification_list.dart';
import '../components/reports_list.dart';

class ListSelector extends StatelessWidget {
  int screen;
  ListSelector({@required this.screen});
  @override
  Widget build(BuildContext context) {
    return screen == 0 ? NotificationList() : ReportsList();
  }
}