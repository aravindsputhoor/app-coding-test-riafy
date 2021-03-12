import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:instagram_ui_flutter/models/news_feed.dart';

class DbStudentManager {
  Database _database;

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(join(await getDatabasesPath(), "nf.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE newsfeed(id TEXT, channelname TEXT, thumbnail TEXT, title TEXT)",
        );
      });
    }
  }

  Future<int> insertNewsfeed(Newsfeed newsfeed) async {
    await openDb();
    return await _database.insert('newsfeed', newsfeed.toMap());
  }

  Future<List<Newsfeed>> getNewsfeedList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('newsfeed');
    return List.generate(maps.length, (i) {
      return Newsfeed(
        id: maps[i]['id'],
        channelname: maps[i]['channelname'],
        thumbnail: maps[i]['thumbnail'],
        title: maps[i]['title'],
      );
    });
  }

  Future<int> updateNewsfeed(Newsfeed newsfeed) async {
    await openDb();
    return await _database.update('newsfeed', newsfeed.toMap(),
        where: "id = ?", whereArgs: [newsfeed.id]);
  }

  Future<void> deleteNewsfeed(String id) async {
    await openDb();
    await _database.delete('newsfeed', where: "id = ?", whereArgs: [id]);
  }
}
