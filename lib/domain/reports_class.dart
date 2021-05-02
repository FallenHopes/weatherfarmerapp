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
  ReportsClass({this.id, this.name, this.culture, this.workDate, this.agregate});
}