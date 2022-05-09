import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'db_counts.dart';

class DBHelper{

  static final DBHelper _instance = DBHelper.internal();
  factory DBHelper() => _instance;
  DBHelper.internal();
  Database? _db;

  Future<Database> get db async {
    return _db = await initDb();
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final path = join(databasesPath, "${packageInfo.appName}.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
          //Criando a tabela de contas
          await db.execute(DBCountsHelper().toScript());
          await isColumnExists(db, "COUNTS", "PWD_REMEMBER");
        });
  }

  Future<int?> close() async{
    Database d = await db;
    d.close();
  }


  Future<bool> isColumnExists(Database db, String table, String column) async{
    bool isExists = false;
    //try {
      List<Map> maps = await db.rawQuery("PRAGMA table_info("+ table +")");

      print('columns:' + jsonEncode(maps));

      /*if (maps != null) {
        for (Map m in maps){
          m.keys.contains(element)
        }
        while (cursor.moveToNext()) {
          String name = cursor.getString(cursor.getColumnIndex("name"));
          if (column.equalsIgnoreCase(name)) {
            isExists = true;
            break;
          }
        }
      }

    } finally {
      if (cursor != null && !cursor.isClose())
        cursor.close();
    }*/
    return isExists;
  }



}