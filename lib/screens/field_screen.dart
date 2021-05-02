import 'package:flutter/material.dart';
import 'package:weatherfarmer/domain/notification_class.dart';
import 'package:weatherfarmer/domain/reports_class.dart';
import '../services/notifications_service.dart';
import '../services/reports_service.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import '../screens/report_screen.dart';

class FieldScreen extends StatelessWidget {
  NotificationClass field;
  BuildContext oldContext;
  FieldScreen({@required this.field, @required this.oldContext});

  Widget myText(String inputText, [double size=20.0]){
    return Container(
      child: Text(
        inputText,
        style: TextStyle(
          color: Colors.black,
          fontSize: size,
        ),
        textAlign: TextAlign.center,
      ),
      margin: EdgeInsets.symmetric(
        vertical: 15
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(field.title)
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            myText('Площадь: ${field.square} га'),
            myText('Технология посева: ${field.sowingTechnology}'),
            myText('Влагозапас: ${field.moistureStorage} см в глубину'),
            myText('Органолептически: ${field.organoleptically}'),
            myText('Рельеф поля: ${field.relief}'),
            myText('Склон поля: ${field.slope}'),
            myText('Тип почвы: ${field.soilType}'),
            myText('Род почвы: ${field.kindOfSoil}'),
            myText('Разновидность почвы: ${field.soilVariety}'),
            myText('Рекоммендации с предыдущих работ:'),
            Container(
              child: myText('${field.recommendations}', 15.0),
              margin: EdgeInsets.symmetric(
                horizontal: 30
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey
                )
              ),
            ),
            myText('Расположение на карте:'),
            Container(
              child: FlutterMap(
                options: MapOptions(
                  center: field.coordinates,
                  zoom: 10.0
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c']
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: field.coordinates,
                        builder: (ctx) => Container(
                          child: Icon(
                            Icons.assistant_photo_outlined,
                            size: 50.0,
                          )
                        )
                      )
                    ]
                  )
                ],
              ),
              height: 700.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black
                )
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 10.0
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Expanded>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5
                      ),
                      child: ElevatedButton(
                        child: Text(
                          "Заполнить отчёт",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                          elevation: MaterialStateProperty.all<double>(2.0)
                        ),
                        onPressed: (){
                          oldContext.read<NotificationsService>().removeNotification(field.id);
                          ReportsClass report = oldContext.read<ReportsService>().addReport(field.id, 'Отчёт: ${field.title}');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReportScreen(
                                report: report,
                                oldContext: oldContext
                              )
                            )
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5
                      ),
                      child: ElevatedButton(
                        child: Text(
                          "Назад",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                          elevation: MaterialStateProperty.all<double>(2.0)
                        ),
                        onPressed: () => Navigator.pop(context)
                      ),
                    ),
                  ),
                ]
              )
            )
          ],
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 10.0
        ),
      )
    );
  }
}