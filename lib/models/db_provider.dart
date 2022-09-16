import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:rifa/models/raffle_item.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static Database? _database;
  static final DbProvider db = DbProvider._();

  final String _dbTableName = 'raffles';

  DbProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = p.join(documentsDirectory.path, 'RufflesDB.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_dbTableName(
          id INT UNIQUE NOT NULL,
          pay BOOLEAN,
          selected BOOLEAN,
          name VARCHAR(100)
        )''');
      },
    );
  }

  Future<int> insertRaffleItem(RaffleItem item) async {
    final db = await database;
    return await db.insert(_dbTableName, item.toMap());
  }

  Future<List<RaffleItem>> getRaffleItems() async {
    final db = await database;
    final res = await db.query(_dbTableName);
    return res.isNotEmpty
        ? res.map((raffleItem) => RaffleItem.fromMap(raffleItem)).toList()
        : List.empty();
  }

  Future<RaffleItem> getRaffleItem(int id) async {
    final db = await database;
    final res = await db.query(_dbTableName, where: 'id = $id');
    return RaffleItem.fromMap(res.first);
  }

  Future<int> updateRaffle(RaffleItem updatedItem) async {
    final db = await database;
    final res = db.update(_dbTableName, updatedItem.toMap(),
        where: 'id = ?', whereArgs: [updatedItem.id]);
    debugPrint("${updatedItem.id}");
    return res;
  }
}
