import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:rifa/models/raffle_item.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static Database? _database;
  static DbProvider db = DbProvider._();

  DbProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'RufflesDB.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE raffles(
          id INTEGER PRIMARY KEY,
          pay BOOLEAN,
          selected BOOLEAN,
          name VARCHAR(100)
        )''');
      },
    );
  }

  Future<int> newRaffleItem(RaffleItem item) async {
    final db = await database;
    return await db
        .insert('raffles', {'$item.toJson()': ConflictAlgorithm.replace});
  }

  Future<List<RaffleItem>> getRaffleItems() async {
    final db = await database;
  }
}
