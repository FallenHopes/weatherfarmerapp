import 'package:latlong/latlong.dart';

class NotificationClass{
  /**Айди */
  int id;
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
      sowingTechnology: json['sowing_technology'],
      moistureStorage: json['moisture_storage'].toDouble(),
      organoleptically: json['organoleptically'],
      relief: json['relief'],
      slope: json['slope'],
      soilType: json['soil_type'],
      kindOfSoil: json['kind_of_soil'],
      soilVariety: json['soil_variety'],
      recommendations: json['recommendations'],
      coordinates: LatLng(json['lat'], json['lng'])
    );
  }
}