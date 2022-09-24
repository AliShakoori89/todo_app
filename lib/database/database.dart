import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/task_model.dart';

class DataBaseHelper{
  DataBaseHelper();

  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;
  static const table = 'my_table';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnDescription = 'description';
  static const columnDone = 'done';

  DataBaseHelper._privateConstructor();

  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async =>
      _database ??= await _initiateDatabase();

  _initiateDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $table ('
        '$columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
        '$columnTitle TEXT,'
        '$columnDescription TEXT,'
        '$columnDone TEXT,'
        ')'
    );
  }

  Future<bool> saveTaskToDataBase(TaskModel taskModel) async {
    var dbServicesItem = await database;

    print('CCCCCCCCCCCC    ');

    await dbServicesItem.insert (
        table, taskModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('CCCCCCCCCCCC    '+ taskModel.toJson().toString());
    return true;
  }

  Future<List<TaskModel>> getAllTasks() async {
    var dbTask = await database;
    List listMap = await dbTask
        .rawQuery('SELECT * FROM my_table');

    print('BBBBBBBBBBBBBBB  '+listMap.toString());
    var listServicesDatabase = <TaskModel>[];
    for (Map<String, dynamic> m in listMap) {
      listServicesDatabase.add(TaskModel.fromJson(m));
      print(m);
    }
    return listServicesDatabase;
  }

  Future<int> deleteTask(int id) async {
    print("id is too delete");
    print(id);
    var myCityDB = await database;
    return await myCityDB.delete("my_table", where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateTaskStatus(TaskModel taskModel) async {
    var myCityDB = await database;
    return await myCityDB.update("my_table", taskModel.toJson(),
        where: '$columnId = ?', whereArgs: [taskModel.id]);
  }
}