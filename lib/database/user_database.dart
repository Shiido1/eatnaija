import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final userTable = 'userTable';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "eatnaija.db");

    var database = await openDatabase(
      path,
      version: 2,
      onCreate: initDB,
      onUpgrade: onUpgrade,
    );
    return database;
  }

  void onUpgrade(
    Database database,
    int oldVersion,
    int newVersion,
  ) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $userTable ("
        "id INTEGER PRIMARY KEY, "
        "name TEXT, "
        "email TEXT, "
        "email_verified_at TEXT, "
        "two_factor_secret TEXT, "
        "two_factor_recovery_codes TEXT, "
        "current_team_id TEXT, "
        "image TEXT NULL, "
        "created_at TEXT, "
        "updated_at TEXT, "
        "phone TEXT NULL, "
        "address TEXT, "
        "otp TEXT NULL,"
        "city TEXT NULL, "
        "state TEXT NULL, "
        "token TEXT, "
        "cart INTEGER "
        ")");
  }
}
