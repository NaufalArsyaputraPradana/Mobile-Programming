import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:todolist/todo.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(
      documentscDirectory.path,
      'todolist.db',
    );
    var theDb = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE 
        IF NOT EXISTS todos 
        (
          id INTEGER PRIMARY KEY autoincrement,
          nama TEXT NOT NULL,
          deskripsi TEXT NOT NULL,
          done INTEGER NOT NULL default 0
        )   
        ''');
  }

  Future<List<Todo>> getAllTodos() async {
    var dbClient = await db;
    var todos = await dbClient!.query('todos');
    return todos.map((todo) => Todo.fromMap(todo)).toList();
  }

  Future<int> addTodo(Todo todo) async {
    var dbClient = await db;
    return await dbClient!.insert('todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateTodo(Todo todo) async {
    var dbClient = await db;
    return await dbClient!
        .update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<int> deleteTodo(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  Future<Todo> getTodoById(int id) async {
    var dbClient = await db;
    var todo = await dbClient!.query('todos', where: 'id = ?', whereArgs: [id]);
    return todo.map((todo) => Todo.fromMap(todo)).single;
  }

  Future<List<Todo>> getTodoByTitle(String title) async {
    var dbClient = await db;
    var todo = await dbClient!
        .query('todos', where: 'title like ?', whereArgs: [title]);
    return todo.map((todo) => Todo.fromMap(todo)).toList();
  }
}
