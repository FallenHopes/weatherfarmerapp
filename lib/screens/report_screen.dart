import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  String reportId;
  BuildContext oldContext;
  ReportScreen({@required this.reportId, @required this.oldContext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Id of field: $reportId')
      ),
      body: Container()
    );
  }
}