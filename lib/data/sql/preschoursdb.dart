import 'package:managents/models/PrescHoursModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

final String tableIrrigHour = 'prescHour';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDateTime = 'PrescHourDateTime';
final String columnPending = 'isPending';
final String columnColorIndex = 'gradientColorIndex';

class HourPrescDB {
  static Database _database;
  static HourPrescDB _hourPrescDB;

  HourPrescDB._createInstance();
  factory HourPrescDB() {
    if (_hourPrescDB == null) {
      _hourPrescDB = HourPrescDB._createInstance();
    }
    return _hourPrescDB;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "prescHour.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableIrrigHour ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnDateTime text not null,
          $columnPending integer,
          $columnColorIndex integer)
        ''');
      },
    );
    return database;
  }

  void insertAlarm(PrescHoursModel prescHoursModel) async {
    var db = await this.database;
    var result = await db.insert(tableIrrigHour, prescHoursModel.toMap());
    print('result : $result');
  }

  Future<List<PrescHoursModel>> getHoursPresc() async {
    List<PrescHoursModel> _irrigHours = [];

    var db = await this.database;
    var result = await db.query(tableIrrigHour);
    result.forEach((element) {
      var prescHoursModel = PrescHoursModel.fromMap(element);
      _irrigHours.add(prescHoursModel);
    });

    return _irrigHours;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db
        .delete(tableIrrigHour, where: '$columnId = ?', whereArgs: [id]);
  }
}
