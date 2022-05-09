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

    return await openDatabase(path, version: 2,
          onCreate: (Database db, int newerVersion) async {
            await db.execute(DBCountsHelper().toScript());
          },
          onUpgrade: (Database db, int oldVersion, int newVersion) async {
            if (oldVersion == 1) {
              db.execute(DBCountsHelper().toScriptAddPwdRemember());
              print('Upgrade database to version 2');
            }
          }
        );

  }

  Future<int?> close() async{
    Database d = await db;
    d.close();
  }

}