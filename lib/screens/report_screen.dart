import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weatherfarmer/domain/reports_class.dart';
import 'package:weatherfarmer/services/reports_service.dart';

class ReportScreen extends StatefulWidget {
  ReportsClass report;
  BuildContext oldContext;
  ReportScreen({@required this.report, @required this.oldContext});

  @override
  _ReportScreenState createState() => _ReportScreenState(report: report, oldContext: oldContext);
}

class _ReportScreenState extends State<ReportScreen> {
  ReportsClass report;
  BuildContext oldContext;
  List culture = ['Озимая пшеница','Яровая пшеница','Ячмень','Лен масличный',
  'Подсолнечник','Нут','Чечевица','Горох','Соя','Кукуруза','Сорго, Просо',
  'Гречиха','Горчица'];

  _ReportScreenState({@required this.report, @required this.oldContext});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${report.name}")
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListView(
          children: <Container>[
            _headtitle("Выберите обрабатываемую культуру:"),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: DropdownButton(
                underline: Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Theme.of(context).primaryColor))
                  ),
                ),
                iconEnabledColor: Theme.of(context).primaryColor,
                iconSize: 40.0,
                isExpanded: true,
                elevation: 3,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20
                ),
                value: report.culture,
                onChanged: (newCulture){
                  setState((){
                    report.culture = newCulture;
                  });
                },
                items: culture.map((c){
                  return DropdownMenuItem(
                    child: Text(c),
                    value: c,
                  );
                }).toList(),
              ),
            ),
            _headtitle("Дата проведения работ:"),
            _dateconfigure(report.workDate),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: _button(
                "Изменить дату", 
                Theme.of(context).primaryColor, 
                ()async{
                  final DateTime picked = await showDatePicker(
                    context: context, 
                    initialDate: report.workDate, 
                    firstDate: DateTime(2000), 
                    lastDate: DateTime(2050),
                    helpText: "Дата проведения работ",
                    cancelText: "Отменить",
                    confirmText: "Подтвердить",
                    builder: (BuildContext context, Widget child){
                      return Theme(
                        data: ThemeData.light().copyWith(
                            colorScheme: ColorScheme.fromSwatch(
                              primarySwatch: Colors.green,
                              primaryColorDark: Colors.green,
                              accentColor: Colors.green,
                            ),
                          dialogBackgroundColor:Colors.white,
                        ),
                        child: child,
                      );
                    }
                  );
                  if (picked != null && picked != report.workDate){
                    setState((){
                      report.workDate = picked;
                    });
                  }
                }
              ),
            ),
            _headtitle("Используемый агрегат:"),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                initialValue: report.agregate,
                onChanged: (newVal){
                  setState((){
                    report.agregate = newVal;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Введите название",
                ),
                cursorHeight: 30,
                style: TextStyle(
                  fontSize: 20
                ),
                textAlign: TextAlign.center,
              ),
            ),
            _headtitle("Химическая обработка:"),
          ],
        ),
      )
    );
  }

  Widget _headtitle(String title){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _dateconfigure(DateTime date){
    if (date == null){
      date = DateTime.now();
      report.workDate = date;
    }
    String days;
    String month;
    if (date.day < 10){
      days = '0${date.day}';
    }
    else{
      days = '${date.day}';
    }
    if (date.month < 10){
      month = '0${date.month}';
    }
    else{
      month = '${date.month}';
    }
    return Container(
      child: Text(
        "$days.$month.${date.year}",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 35
        ),
      ),
    );
  }

  Widget _button(String title, Color backgroundColor, Function onPress){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ElevatedButton(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20
          ),
        ),
        onPressed: onPress,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          elevation: MaterialStateProperty.all<double>(2.0)
        ),
      ),
    );
  }
}