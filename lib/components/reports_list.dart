import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherfarmer/screens/report_screen.dart';
import 'package:weatherfarmer/services/reports_service.dart';

class ReportsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: context.watch<ReportsService>().reports != null ? ListView.builder(
        itemCount: context.watch<ReportsService>().reports.length,
        itemBuilder: (context, i){
          return Card(
            elevation: 2.0,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Container(
              child: ListTile(
                leading: Icon(Icons.analytics_outlined, size: 35.0, color: Colors.black),
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                title: Text(
                  context.watch<ReportsService>().reports[i].name, 
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  )
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => ReportScreen(
                        reportId: context.watch<ReportsService>().reports[i].id,
                        oldContext: context,
                      )
                    )
                  );
                },
              ),
            ),
          );
        },
      ) : Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Text("Загрузка...")
        )
      )
    );
  }
}