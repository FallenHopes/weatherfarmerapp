import 'package:flutter/material.dart';
import 'package:weatherfarmer/domain/reports_class.dart';
import 'package:flutter/widgets.dart';
import 'package:weatherfarmer/services/database_service.dart';
import 'package:weatherfarmer/services/toast_service.dart';

class ReportsService with ChangeNotifier{
  List<ReportsClass> reports = [];
  bool loading = false;

  void getReportsFromLocalStorage() async{
    try{
      loading = true;
      notifyListeners();
      reports = await DatabaseService.db.getReports();
      loading = false;
      notifyListeners();
    }catch(e){
      loading = false;
      notifyListeners();
      ToastService.tst("Ошибка: $e", Colors.red);
      print("Ошибка в функции получения из базы данных: $e");
    }
  }

  ReportsClass addReport(int id, String name){
    try{
      loading = true;
      notifyListeners();
      ReportsClass tmp = ReportsClass(
        id: id, 
        name: name,
        culture: 'Озимая пшеница',
        workDate: DateTime.now(),
        agregate: '',
        chemicalTreatment: [],
        drugs: '',
        illness: [],
        pests: [],
        weeds: [],
        recommendations: ''
      );
      DatabaseService.db.insert(tmp);
      reports.add(tmp);
      ToastService.tst("Запись успешно создана", Colors.green);
      loading = false;
      notifyListeners();
      return tmp;
    }catch(e){
      loading = false;
      notifyListeners();
      ToastService.tst("Ошибка: $e", Colors.red);
      print("Ошибка в функции добавления записи: $e");
    }
  }

  Future<void> sendReportToServer(ReportsClass report) async{
    try {
      loading = true;
      notifyListeners();
      // Async code
      await DatabaseService.db.delete(report.id);
      reports.removeWhere((rep) => rep.id == report.id);
      notifyListeners();
      ToastService.tst("Отчёт отправлен", Colors.green);
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      ToastService.tst("Ошибка: $e", Colors.red);
      print("Ошибка в функции отправки отчёта на сервер: $e");
    }
  }

  Future<void> saveReport(ReportsClass report) async{
    try{
      loading = true;
      notifyListeners();
      await DatabaseService.db.update(report);
      ToastService.tst("Запись сохранена", Colors.green);
      loading = false;
      notifyListeners();
    }catch(e){
      loading = false;
      notifyListeners();
      ToastService.tst("Ошибка: $e", Colors.red);
      print("Ошибка в функции сохранения записи: $e");
    }
  }
}