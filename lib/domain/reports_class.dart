class ReportsClass{
  /**Уникальный идентификатор*/
  String id;
  /**Название уведомления*/
  String name;
  /**Обрабатываемая культура*/
  String culture;
  /**Дата проведения работ*/
  DateTime workDate;
  /**Используемый агрегат*/
  String agregate;
  /**Химическая обработка*/
  List<String> chemicalTreatment = [];
  /**Препараты*/
  String drugs;
  /**Болезни*/
  List<Map<String, dynamic>> illness = [];
  ReportsClass({ this.id, this.name, this.culture, this.workDate, this.agregate, this.chemicalTreatment,
  this.drugs, this.illness});

  void removeIllness(int idx){
    this.illness.removeAt(idx);
  }
}