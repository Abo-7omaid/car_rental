import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'car_rental.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites (
            id TEXT PRIMARY KEY,
            carId TEXT NOT NULL,
            carName TEXT NOT NULL,
            carImage TEXT,
            pricePerDay REAL,
            createdAt TEXT DEFAULT CURRENT_TIMESTAMP
          )
        ''');
      },
    );
  }

  Future<void> addFavorite(Map<String, dynamic> favorite) async {
    final db = await database;
    await db.insert('favorites', favorite, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    return db.query('favorites');
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }
}