import 'package:restaurant_app/data/model/general/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  static const String _databaseName = "restaurant_app.db";
  static const String _tableName = "favorite_restaurants";
  static const int _version = 9;

  Future<void> createTables(Database database) async {
    await database.execute(
      """
      CREATE TABLE $_tableName (
        id TEXT,
        name TEXT,
        description TEXT,
        pictureId TEXT,
        city TEXT,
        rating DOUBLE
      )
      """
    );
  }

  Future<Database> _initializeDb() async {
    return openDatabase(
      _databaseName,
      version: _version,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  Future<List<Restaurant>> readAllFavRestaurants() async {
    final db = await _initializeDb();
    final results = await db.query(_tableName);

    return results.map((result) => Restaurant.fromJson(result)).toList();
  }

  Future<Restaurant> readFavRestaurantsById(String id) async {
    final db = await _initializeDb();
    final results = await db.query(_tableName, where: "id = ?", whereArgs: [id], limit: 1);

    return results.map((result) => Restaurant.fromJson(result)).first;
  }

  Future<int> createFavRestaurant(Restaurant restaurant) async {
    final db = await _initializeDb();
    final data = restaurant.toJson();
    final id = await db.insert(_tableName, data, conflictAlgorithm: ConflictAlgorithm.replace);
    
    return id;
  }

  Future<int> deleteFavRestaurant(String id) async {
    final db = await _initializeDb();
    final result = await db.delete(_tableName, where: "id = ?", whereArgs: [id]);

    return result;
  }
}