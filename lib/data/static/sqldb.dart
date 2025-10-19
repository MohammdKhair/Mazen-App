// ignore_for_file: avoid_print

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' ;
class SqlDb {
  static Database? _db ;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    }else{
      return _db;
    }
  }


  initialDB() async{
    String databasepath = await getDatabasesPath();
    String path = join(databasepath,'diary.db');
    Database mydb = await openDatabase(path,onCreate: _onCreate,version: 1,onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db , int oldversion , int newversion)async{
    
  }

  _onCreate(Database db , int version)async{

    Batch batch = db.batch();
    batch.execute('''
    CREATE TABLE "diary"(
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT  ,
    "date" TEXT NOT NULL ,
    "Basis_of_the_lawsuit" INTEGER ,
    "parties_to_the_case" TEXT ,
    "reason_for_postponement" TEXT 


    )
    ''');
    await batch.commit();
    print("on===============================Creat database and table");
  }

  readData(String sql) async {
    Database? mydb = await db ;
    List<Map> response = await mydb!.rawQuery(sql);
    return response ;
  }

  insertData(String sql) async {
    Database? mydb = await db ;
    int response = await mydb!.rawInsert(sql);
    return response ;
  }

  updateData(String sql) async {
    Database? mydb = await db ;
    int response = await mydb!.rawUpdate(sql);
    return response ;
  }
  deleteData(String sql) async {
    Database? mydb = await db ;
    int response = await mydb!.rawDelete(sql);
    return response ;
  }

  mydeleteDatabase() async{
    String databasepath = await getDatabasesPath();
    String path = join(databasepath,'note2.db');
    print('delet done');
    await deleteDatabase(path);
  }

}
