import 'package:weatherfarmer/services/database_service.dart';
import 'dart:convert';

class ReportsClass{
  /**Уникальный идентификатор*/
  int id;
  /**Название уведомления*/
  String name;
  /**Обрабатываемая культура*/
  String culture;
  /**Дата проведения работ*/
  DateTime workDate;
  /**Используемый агрегат*/
  String agregate;
  /**Химическая обработка*/
  List chemicalTreatment = [];
  /**Препараты*/
  String drugs;
  /**Болезни*/
  List illness = [];
  /**Вредители*/
  List pests = [];
  /**Сорянки*/
  List weeds = [];
  /**Рекомендации*/
  String recommendations;

  ReportsClass({ this.id, this.name, this.culture, this.workDate, this.agregate, this.chemicalTreatment,
  this.drugs, this.illness, this.pests, this.weeds, this.recommendations});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseService.COLUMN_ID: id,
      DatabaseService.COLUMN_NAME: name,
      DatabaseService.COLUMN_CULTURE: culture,
      DatabaseService.COLUMN_WORKDATE: workDate.toString(),
      DatabaseService.COLUMN_AGREGATE: agregate,
      DatabaseService.COLUMN_CHEMICALTREATMENT: chemicalTreatment.map((el) => "\"$el\"").toList().toString(),
      DatabaseService.COLUMN_DRUGS: drugs,
      DatabaseService.COLUMN_ILLNESS: illness.map(
        (el) => {
          "\"name\"": "\"${el["name"]}\"", 
          "\"percent\"": "\"${el["percent"]}\"", 
          "\"effect\"": "\"${el["effect"]}\""
        }).toList().toString(),
      DatabaseService.COLUMN_PESTS: pests.map(
        (el) => {
          "\"name\"": "\"${el["name"]}\"", 
          "\"stage\"": "\"${el["stage"]}\"", 
          "\"count\"": "\"${el["count"]}\"", 
          "\"damage\"": "\"${el["damage"]}\"", 
          "\"effect\"": "\"${el["effect"]}\""
          }).toList().toString(),
      DatabaseService.COLUMN_WEEDS: weeds.map(
        (el) => {
          "\"name\"": "\"${el["name"]}\"", 
          "\"phase\"": "\"${el["phase"]}\"", 
          "\"count\"": "\"${el["count"]}\"",  
          "\"effect\"": "\"${el["effect"]}\""
          }).toList().toString(),
      DatabaseService.COLUMN_RECOMMENDATIONS: recommendations
    };
    return map;
  }

  ReportsClass.fromMap(Map<String, dynamic> map){
    id = map[DatabaseService.COLUMN_ID];
    name = map[DatabaseService.COLUMN_NAME];
    culture = map[DatabaseService.COLUMN_CULTURE];
    workDate = DateTime.parse(map[DatabaseService.COLUMN_WORKDATE]);
    agregate = map[DatabaseService.COLUMN_AGREGATE];
    chemicalTreatment = json.decode(map[DatabaseService.COLUMN_CHEMICALTREATMENT]);
    drugs = map[DatabaseService.COLUMN_DRUGS];
    illness = json.decode(map[DatabaseService.COLUMN_ILLNESS]);
    pests = json.decode(map[DatabaseService.COLUMN_PESTS]);
    weeds = json.decode(map[DatabaseService.COLUMN_WEEDS]);
    recommendations = map[DatabaseService.COLUMN_RECOMMENDATIONS];
  }
}