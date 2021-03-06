import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weatherfarmer/domain/reports_class.dart';
import 'package:weatherfarmer/services/reports_service.dart';

class ReportScreen extends StatefulWidget {
  ReportScreen({@required this.report, @required this.oldContext});

  ReportsClass report;
  BuildContext oldContext;

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final List<String> culture = ["Озимая пшеница","Яровая пшеница","Ячмень","Лен масличный",
  "Подсолнечник","Нут","Чечевица","Горох","Соя","Кукуруза","Сорго, Просо",
  "Гречиха","Горчица"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.report.name}")
      ),
      body: GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus){
            currentFocus.unfocus();
          }
        },
        child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListView(
          physics: BouncingScrollPhysics(),
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
                value: widget.report.culture,
                onChanged: (newCulture){
                  setState((){
                    widget.report.culture = newCulture;
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
            _dateconfigure(widget.report.workDate),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: _button(
                "Изменить дату", 
                Theme.of(context).primaryColor, 
                ()async{
                  final DateTime picked = await showDatePicker(
                    context: context, 
                    initialDate: widget.report.workDate, 
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
                  if (picked != null && picked != widget.report.workDate){
                    setState((){
                      widget.report.workDate = picked;
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
                initialValue: widget.report.agregate,
                onChanged: (newVal){
                  setState((){
                    widget.report.agregate = newVal;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Введите название",
                ),
                cursorHeight: 20,
                style: TextStyle(
                  fontSize: 20
                ),
                textAlign: TextAlign.center,
              ),
            ),
            _headtitle("Химическая обработка:"),
            _customCheckBox("Глифосатная"),
            _customCheckBox("Подкормка"),
            _customCheckBox("Гербицидная"),
            _customCheckBox("Инсектицидная"),
            _customCheckBox("Фунгицидная"),
            _customCheckBox("Десикация"),
            _headtitle("Препараты (наименование, дозировка)"),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor
                ),
                borderRadius: BorderRadius.circular(5.0)
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 15
              ),
              child: TextFormField(
                initialValue: widget.report.drugs,
                onChanged: (val){
                  setState((){
                    widget.report.drugs = val;
                  });
                },
                maxLines: 3,
                cursorHeight: 20,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Введите название, дозировку препаратов в литрах, либо в кг/га",
                  hintStyle: TextStyle(
                    color: Colors.grey
                  )
                ),
              ),
            ),
            _headtitle("Выявленные болезни:"),
            _illnessCards(),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 30
              ),
              child: _button(
                "+ Добавить болезнь",
                Theme.of(context).primaryColor,
                (){
                  setState((){
                    widget.report.illness.add({"name": "", "percent": "", "effect": ""});
                  });
                }
              ),
            ),
            _headtitle("Выявленные вредители:"),
            _pestsCards(),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 30
              ),
              child: _button(
                "+ Добавить вредителя",
                Theme.of(context).primaryColor,
                (){
                  setState((){
                    widget.report.pests.add({"name": "", "stage": "", "count": "", "damage": "", "effect": ""});
                  });
                }
              ),
            ),
            _headtitle("Выявленные сорняки:"),
            _weedsCards(),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 30
              ),
              child: _button(
                "+ Добавить сорняк",
                Theme.of(context).primaryColor,
                (){
                  setState((){
                    widget.report.weeds.add({"name": "", "phase": "", "count": "", "effect": ""});
                  });
                }
              ),
            ),
            _headtitle("Рекомендации:"),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor
                ),
                borderRadius: BorderRadius.circular(5.0)
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 15
              ),
              child: TextFormField(
                initialValue: widget.report.recommendations,
                onChanged: (val){
                  setState((){
                    widget.report.recommendations= val;
                  });
                },
                maxLines: 3,
                cursorHeight: 20,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Какие-либо рекомендации для следующей работы",
                  hintStyle: TextStyle(
                    color: Colors.grey
                  )
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 40,
                left: 25,
                right: 25,
                bottom: 5
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                        "Сохранить отчёт",
                        style: TextStyle(
                          fontSize: 15
                        ),
                      ),
                      onPressed: () async{
                        await widget.oldContext.read<ReportsService>().saveReport(widget.report);
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)
                      ),
                    )
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                        "Назад",
                        style: TextStyle(
                          fontSize: 15
                        ),
                      ),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey)
                      ),
                    )
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 0,
                left: 25,
                right: 25,
                bottom: 20
              ),
              child: ElevatedButton(
                child: Text(
                  "Загрузить отчёт на сервер",
                  style: TextStyle(
                    fontSize: 15
                  ),
                ),
                onPressed: () async{
                  await widget.oldContext.read<ReportsService>().sendReportToServer(widget.report);
                  Navigator.of(context).pop();
                }
              ),
            )
          ],
        ),
      )
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
      widget.report.workDate = date;
    }
    String days;
    String month;
    if (date.day < 10){
      days = "0${date.day}";
    }
    else{
      days = "${date.day}";
    }
    if (date.month < 10){
      month = "0${date.month}";
    }
    else{
      month = "${date.month}";
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

  Widget _customCheckBox(String value){
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: CheckboxListTile(
        value: widget.report.chemicalTreatment.contains(value),
        onChanged: (val){
          setState((){
            val 
            ?
            widget.report.chemicalTreatment.add(value)
            :
            widget.report.chemicalTreatment.remove(value);
          });
        },
        title: Text(
          value,
          style: TextStyle(fontSize: 20),
        ),
        activeColor: Theme.of(context).primaryColor,
      )
    );
  }

  Widget _illnessCards(){
    return Container(
      child: ListView.builder(
        itemCount: widget.report.illness.length,
        itemBuilder: (context, i){
          final item = widget.report.illness[i];
          return Container(
            key: ObjectKey(item),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor
              )
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  top: -20,
                  right: -20,
                  child: FloatingActionButton(
                    backgroundColor: Colors.red.shade300,
                    elevation: 2,
                    mini: true,
                    child: Text(
                      "x",
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                    onPressed: (){
                      setState((){
                        widget.report.illness.removeAt(i);
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15
                  ),
                  child: TextFormField(
                    initialValue: widget.report.illness[i]["name"],
                    onChanged: (newVal){
                      setState((){
                        widget.report.illness[i]["name"] = newVal;
                      });
                    },
                    textAlign: TextAlign.center,
                    cursorHeight: 20,
                    style: TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      hintText: "Наименование болезни",
                      hintStyle: TextStyle(
                        color: Theme.of(context).primaryColor
                      )
                    ),
                  )
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 85
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: widget.report.illness[i]["percent"],
                    onChanged: (newVal){
                      setState((){
                        widget.report.illness[i]["percent"] = newVal;
                      });
                    },
                    textAlign: TextAlign.center,
                    cursorHeight: 20,
                    style: TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      hintText: "Процент заражения",
                      hintStyle: TextStyle(
                        color: Theme.of(context).primaryColor
                      )
                    ),
                  )
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 155,
                    bottom: 15,
                    left: 40,
                    right: 40
                  ),
                  child: TextFormField(
                    initialValue: widget.report.illness[i]["effect"],
                    onChanged: (newVal){
                      setState((){
                        widget.report.illness[i]["effect"] = newVal;
                      });
                    },
                    textAlign: TextAlign.center,
                    cursorHeight: 20,
                    style: TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      hintText: "Эффективность обработки",
                      hintStyle: TextStyle(
                        color: Theme.of(context).primaryColor
                      )
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      )
    );
  }

  Widget _weedsCards(){
    return Container(
      child: ListView.builder(
        itemCount: widget.report.weeds.length,
        itemBuilder: (context, i){
          final item = widget.report.weeds[i];
          return Container(
            key: ObjectKey(item),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor
              )
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  top: -20,
                  right: -20,
                  child: FloatingActionButton(
                    backgroundColor: Colors.red.shade300,
                    elevation: 2,
                    mini: true,
                    child: Text(
                      "x",
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                    onPressed: (){
                      setState((){
                        widget.report.weeds.removeAt(i);
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15
                  ),
                  child: TextFormField(
                    initialValue: widget.report.weeds[i]["name"],
                    onChanged: (newVal){
                      setState((){
                        widget.report.weeds[i]["name"] = newVal;
                      });
                    },
                    textAlign: TextAlign.center,
                    cursorHeight: 20,
                    style: TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      hintText: "Наименование сорняка",
                      hintStyle: TextStyle(
                        color: Theme.of(context).primaryColor
                      )
                    ),
                  )
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 85
                  ),
                  child: TextFormField(
                    initialValue: widget.report.weeds[i]["phase"],
                    onChanged: (newVal){
                      setState((){
                        widget.report.weeds[i]["phase"] = newVal;
                      });
                    },
                    textAlign: TextAlign.center,
                    cursorHeight: 20,
                    style: TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      hintText: "Фаза развития",
                      hintStyle: TextStyle(
                        color: Theme.of(context).primaryColor
                      )
                    ),
                  )
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 155,
                    bottom: 15,
                    left: 40,
                    right: 40
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: widget.report.weeds[i]["count"],
                    onChanged: (newVal){
                      setState((){
                        widget.report.weeds[i]["count"] = newVal;
                      });
                    },
                    textAlign: TextAlign.center,
                    cursorHeight: 20,
                    style: TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      hintText: "Количество (шт/м2)",
                      hintStyle: TextStyle(
                        color: Theme.of(context).primaryColor
                      )
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 225,
                    bottom: 15,
                    left: 40,
                    right: 40
                  ),
                  child: TextFormField(
                    initialValue: widget.report.weeds[i]["effect"],
                    onChanged: (newVal){
                      setState((){
                        widget.report.weeds[i]["effect"] = newVal;
                      });
                    },
                    textAlign: TextAlign.center,
                    cursorHeight: 20,
                    style: TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      hintText: "Эффективность обработки",
                      hintStyle: TextStyle(
                        color: Theme.of(context).primaryColor
                      )
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      )
    );
  }

  Widget _pestsCards(){
    return Container(
      child: ListView.builder(
        itemCount: widget.report.pests.length,
        itemBuilder: (context, i){
          final item = widget.report.pests[i];
          return Container(
            key: ObjectKey(item),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor
              )
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  top: -20,
                  right: -20,
                  child: FloatingActionButton(
                    backgroundColor: Colors.red.shade300,
                    elevation: 2,
                    mini: true,
                    child: Text(
                      "x",
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                    onPressed: (){
                      setState((){
                        widget.report.pests.removeAt(i);
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15
                  ),
                  child: TextFormField(
                    initialValue: widget.report.pests[i]["name"],
                    onChanged: (newVal){
                      setState((){
                        widget.report.pests[i]["name"] = newVal;
                      });
                    },
                    textAlign: TextAlign.center,
                    cursorHeight: 20,
                    style: TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      hintText: "Наименование вредителя",
                      hintStyle: TextStyle(
                        color: Theme.of(context).primaryColor
                      )
                    ),
                  )
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 85
                  ),
                  child: TextFormField(
                    initialValue: widget.report.pests[i]["stage"],
                    onChanged: (newVal){
                      setState((){
                        widget.report.pests[i]["stage"] = newVal;
                      });
                    },
                    textAlign: TextAlign.center,
                    cursorHeight: 20,
                    style: TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      hintText: "Стадия развития",
                      hintStyle: TextStyle(
                        color: Theme.of(context).primaryColor
                      )
                    ),
                  )
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 155,
                    bottom: 15,
                    left: 40,
                    right: 40
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: widget.report.pests[i]["count"],
                    onChanged: (newVal){
                      setState((){
                        widget.report.pests[i]["count"] = newVal;
                      });
                    },
                    textAlign: TextAlign.center,
                    cursorHeight: 20,
                    style: TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      hintText: "Количество (шт/м2)",
                      hintStyle: TextStyle(
                        color: Theme.of(context).primaryColor
                      )
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 225,
                    bottom: 15,
                    left: 40,
                    right: 40
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: widget.report.pests[i]["damage"],
                    onChanged: (newVal){
                      setState((){
                        widget.report.pests[i]["damage"] = newVal;
                      });
                    },
                    textAlign: TextAlign.center,
                    cursorHeight: 20,
                    style: TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      hintText: "Объём повреждений (%)",
                      hintStyle: TextStyle(
                        color: Theme.of(context).primaryColor
                      )
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 295,
                    bottom: 15,
                    left: 40,
                    right: 40
                  ),
                  child: TextFormField(
                    initialValue: widget.report.pests[i]["effect"],
                    onChanged: (newVal){
                      setState((){
                        widget.report.pests[i]["effect"] = newVal;
                      });
                    },
                    textAlign: TextAlign.center,
                    cursorHeight: 20,
                    style: TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      hintText: "Эффективность обработки",
                      hintStyle: TextStyle(
                        color: Theme.of(context).primaryColor
                      )
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      )
    );
  }
}