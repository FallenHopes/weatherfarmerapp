import 'package:latlong/latlong.dart';

class NotificationClass{
  /**Айди */
  String id;
  /**Название*/
  String title;
  /**Площадь*/
  int square;
  /**Технология посева*/
  String sowingTechnology;
  /**Влагозапас*/
  double moistureStorage;
  /**Органолептически*/
  String organoleptically;
  /**Рельеф поля*/
  String relief;
  /**Склон поля*/
  String slope;
  /**Тип почвы*/
  String soilType;
  /**Род почвы*/
  String kindOfSoil;
  /**Разновидность почвы*/
  String soilVariety;
  /**Рекомендации с предыдущих работ*/
  String recommendations;
  /**Координаты*/
  LatLng coordinates;
  NotificationClass({
    this.id, this.title, this.square, this.sowingTechnology, this.moistureStorage,
    this.organoleptically, this.relief, this.slope, this.soilType, this.kindOfSoil,
    this.soilVariety, this.recommendations, this.coordinates
  });
  factory NotificationClass.fromJson(Map<String, dynamic> json){
    return NotificationClass(
      id: json['id'],
      title: json['title'],
      square: json['square'],
      sowingTechnology: json['sowingTechnology'],
      moistureStorage: json['moistureStorage'].toDouble(),
      organoleptically: json['organoleptically'],
      relief: json['relief'],
      slope: json['slope'],
      soilType: json['soilType'],
      kindOfSoil: json['kindOfSoil'],
      soilVariety: json['soilVariety'],
      recommendations: json['recommendations'],
      coordinates: LatLng(json['coordinates'][0], json['coordinates'][1])
    );
  }
}