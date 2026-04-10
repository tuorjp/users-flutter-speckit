import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user_model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;
  static Database? _testDatabase;

  DatabaseService._internal();

  factory DatabaseService() => _instance;

  /// Allows injecting a database instance for testing (e.g. in-memory)
  static void setTestDatabase(Database? db) {
    _testDatabase = db;
  }

  Future<Database> get database async {
    if (_testDatabase != null) return _testDatabase!;
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'users_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        status TEXT NOT NULL
      )
    ''');

    // Seed mock data
    await db.insert('users', {
      'name': 'Admin User',
      'email': 'admin@admin.com',
      'password': '12345',
      'status': 'Ativo',
    });
    
    // Seed more mock data for the list
    await db.insert('users', {
      'name': 'João Silva',
      'email': 'joao@example.com',
      'password': '123',
      'status': 'Ativo',
    });
    await db.insert('users', {
      'name': 'Maria Souza',
      'email': 'maria@example.com',
      'password': '123',
      'status': 'Inativo',
    });
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }

  Future<bool> isEmailTaken(String email, {int? excludeId}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: excludeId == null ? 'email = ?' : 'email = ? AND id != ?',
      whereArgs: excludeId == null ? [email] : [email, excludeId],
    );
    return maps.isNotEmpty;
  }

  Future<List<UserModel>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) => UserModel.fromMap(maps[i]));
  }

  Future<int> insertUser(UserModel user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<int> updateUser(UserModel user) async {
    final db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
