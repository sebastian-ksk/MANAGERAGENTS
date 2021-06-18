import 'package:managents/models/alarm_info.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

final String tableIrrigHour = 'alarm';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDateTime = 'IrrigHourDateTime';
final String columnPending = 'isPending';
final String columnColorIndex = 'gradientColorIndex';

class HourIrrigDB {
  static Database _database;
  static HourIrrigDB _hourIrrigdb;

  HourIrrigDB._createInstance();
  factory HourIrrigDB() {
    if (_hourIrrigdb == null) {
      _hourIrrigdb = HourIrrigDB._createInstance();
    }
    return _hourIrrigdb;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "alarm.db";

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

  void insertAlarm(IrrigHoursModel IrrigHoursModel) async {
    var db = await this.database;
    var result = await db.insert(tableIrrigHour, IrrigHoursModel.toMap());
    print('result : $result');
  }

  Future<List<IrrigHoursModel>> getAlarms() async {
    List<IrrigHoursModel> _irrigHours = [];

    var db = await this.database;
    var result = await db.query(tableIrrigHour);
    result.forEach((element) {
      var irrigHoursModel = IrrigHoursModel.fromMap(element);
      _irrigHours.add(irrigHoursModel);
    });

    return _irrigHours;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db
        .delete(tableIrrigHour, where: '$columnId = ?', whereArgs: [id]);
  }
}
