import 'package:sqflite/sqflite.dart';
import 'package:super_comics_app/database/app_database.dart';
import 'package:super_comics_app/models/super_hero.dart';

class SuperHeroDao {
  insert(SuperHero hero) async {
    Database database = await AppDatabase().openDB();
    await database.insert(AppDatabase().tableName, hero.toJson());
  }

  delete(SuperHero hero) async {
    Database database = await AppDatabase().openDB();
    await database
        .delete(AppDatabase().tableName, where: "id = ?", whereArgs: [hero.id]);
  }

  Future<List> fetchAll() async {
    Database database = await AppDatabase().openDB();
    List maps = await database.query(AppDatabase().tableName);
    return maps.map((map) => FavoriteHero.fromMap(map)).toList();
  }

  Future<bool> isFavorite(SuperHero hero) async {
    Database database = await AppDatabase().openDB();
    List maps = await database
        .query(AppDatabase().tableName, where: "id = ?", whereArgs: [hero.id]);

    return maps.isNotEmpty;
  }

  Future<void> deleteById(String id) async {
    Database database = await AppDatabase().openDB();
    await database.delete(AppDatabase().tableName, where: "id = ?", whereArgs: [id]);
  }
}