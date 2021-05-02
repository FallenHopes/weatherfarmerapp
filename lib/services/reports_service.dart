import 'package:weatherfarmer/domain/reports_class.dart';
import 'package:flutter/widgets.dart';

class ReportsService with ChangeNotifier{
  List<ReportsClass> reports;

  void getReportsFromLocalStorage() async{
    reports = <ReportsClass>[
      ReportsClass(id: '3', name: 'Отчёт: Поле 3'),
      ReportsClass(id: '4', name: 'Отчёт: Поле 4')
    ];
    notifyListeners();
  }

  void addReport(String id, String name){
    reports.add(ReportsClass(id: id, name: name));
    // async code
  }
}