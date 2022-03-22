import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:package_info/package_info.dart';
import 'db_counts.dart';

class DBHelper{



  static final DBHelper _instance = DBHelper.internal();
  factory DBHelper() => _instance;
  Database? _db;
  DBHelper.internal();

  Future<Database> get db async {
    return _db ?? await initDb();
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final path = join(databasesPath, "${packageInfo.appName}.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
          await db.execute(DBCountsHelper().toScript());
        });
  }

  Future<int?> close() async{
    Database? d = await db;
    d?.close();
  }

}