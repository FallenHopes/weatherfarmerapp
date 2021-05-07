import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherfarmer/screens/report_screen.dart';
import 'package:weatherfarmer/services/reports_service.dart';

class ReportsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (context.watch<ReportsService>().loading){
      return Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Text("Загрузка...")
        )
      );
    }
    return Container(
      child: context.watch<ReportsService>().reports != null && context.watch<ReportsService>().reports.length != 0 ? ListView.builder(
        physics: BouncingScrollPhysics(),
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
                        report: context.watch<ReportsService>().reports[i],
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
          child: Text("Отчётов пока нет")
        )
      )
    );
  }
}