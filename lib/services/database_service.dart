import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weatherfarmer/domain/reports_class.dart';

class DatabaseService{
  static const String TABLE_REPORT = "report";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_CULTURE = "culture";
  static const String COLUMN_WORKDATE = "workDate";
  static const String COLUMN_AGREGATE = "agregate";
  static const String COLUMN_CHEMICALTREATMENT = "chemicalTreatment";
  static const String COLUMN_DRUGS = "drugs";
  static const String COLUMN_ILLNESS = "illness";
  static const String COLUMN_PESTS = "pests";
  static const String COLUMN_WEEDS = "weeds";
  static const String COLUMN_RECOMMENDATIONS = "recommendations";

  DatabaseService._();
  static final DatabaseService db = DatabaseService._();

  Database _database;

  Future<Database> get database async{
    print("Database getter called");
    if (_database != null){
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async{
    String dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'reportDB.db'),
      version: 1,
      onCreate: (Database database, int version) async{
        print("Creating report table");
        await database.execute(
          "CREATE TABLE $TABLE_REPORT ("
          "$COLUMN_ID INTEGER PRIMARY KEY,"
          "$COLUMN_NAME TEXT,"
          "$COLUMN_CULTURE TEXT,"
          "$COLUMN_WORKDATE TEXT,"
          "$COLUMN_AGREGATE TEXT,"
          "$COLUMN_CHEMICALTREATMENT TEXT,"
          "$COLUMN_DRUGS TEXT,"
          "$COLUMN_ILLNESS TEXT,"
          "$COLUMN_PESTS TEXT,"
          "$COLUMN_WEEDS TEXT,"
          "$COLUMN_RECOMMENDATIONS TEXT"
          ")"
        );
      }
    );
  }

  Future<List<ReportsClass>> getReports() async{
    final db = await database;
    var reports = await db.query(
      TABLE_REPORT,
      columns: [COLUMN_ID, COLUMN_NAME, COLUMN_CULTURE, COLUMN_WORKDATE, COLUMN_AGREGATE,
      COLUMN_CHEMICALTREATMENT, COLUMN_DRUGS, COLUMN_ILLNESS, COLUMN_PESTS, COLUMN_WEEDS,
      COLUMN_RECOMMENDATIONS]
    );
    List<ReportsClass> reportsList = [];
    reports.forEach((repMap){
      ReportsClass rep = ReportsClass.fromMap(repMap);
      reportsList.add(rep);
    });
    return reportsList;
  }

  Future<void> insert (ReportsClass report) async{
    final db = await database;
    await db.insert(TABLE_REPORT, report.toMap());
  }

  Future<void> delete(int id) async{
    final db = await database;
    await db.delete(
      TABLE_REPORT,
      where: "id = ?",
      whereArgs: [id]
    );
  }

  Future<void> update(ReportsClass report) async {
    final db = await database;
    await db.update(
      TABLE_REPORT, 
      report.toMap(),
      where: "id = ?",
      whereArgs: [report.id]
    );
  }
}