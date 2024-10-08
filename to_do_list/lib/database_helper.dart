import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_crud_sqflite/todo.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await _initDb();
    return _db;
  }

  DatabaseHelper._internal();

  Future<Database> _initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'todolist.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        completed INTEGER NOT NULL
      )
    ''');
  }

  Future<List<Todo>> getAllTodos() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient!.query('todos');
    return maps.map((todo) => Todo.fromMap(todo)).toList();
  }

  Future<List<Todo>> getTodoByTitle(String title) async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient!.query(
      'todos',
      where: 'title LIKE ?',
      whereArgs: [title],
    );
    return maps.map((todo) => Todo.fromMap(todo)).toList();
  }

  Future<int> insertTodo(Todo todo) async {
    final dbClient = await db;
    return await dbClient!.insert('todos', todo.toMap());
  }

  Future<int> updateTodo(Todo todo) async {
    final dbClient = await db;
    return await dbClient!.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> deleteTodo(int id) async {
    final dbClient = await db;
    return await dbClient!.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
