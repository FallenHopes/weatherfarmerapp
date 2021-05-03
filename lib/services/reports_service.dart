import 'package:weatherfarmer/domain/reports_class.dart';
import 'package:flutter/widgets.dart';

class ReportsService with ChangeNotifier{
  List<ReportsClass> reports;

  void getReportsFromLocalStorage() async{
    reports = <ReportsClass>[
      ReportsClass(id: '3', name: 'Отчёт: Поле 3', chemicalTreatment: []),
      ReportsClass(id: '4', name: 'Отчёт: Поле 4', chemicalTreatment: [])
    ];
    notifyListeners();
  }

  ReportsClass addReport(String id, String name){
    ReportsClass tmp = ReportsClass(id: id, name: name, chemicalTreatment: []);
    reports.add(tmp);
    return tmp;
    // async code
  }
}