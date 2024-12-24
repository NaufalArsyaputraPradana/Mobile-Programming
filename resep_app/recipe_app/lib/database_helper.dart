import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'recipes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE recipes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            preparation_time TEXT,
            ingredients TEXT,
            instructions TEXT
          )
        ''');
      },
    );
  }

  Future<List<Map<String, dynamic>>> getAllRecipes() async {
    final dbClient = await db;
    return await dbClient!.query('recipes');
  }

  Future<int> addRecipe(Map<String, dynamic> recipe) async {
    final dbClient = await db;
    return await dbClient!.insert('recipes', recipe);
  }

  Future<int> updateRecipe(Map<String, dynamic> recipe) async {
    final dbClient = await db;
    return await dbClient!.update(
      'recipes',
      recipe,
      where: 'id = ?',
      whereArgs: [recipe['id']],
    );
  }

  Future<int> deleteRecipe(int id) async {
    final dbClient = await db;
    return await dbClient!.delete('recipes', where: 'id = ?', whereArgs: [id]);
  }
}
