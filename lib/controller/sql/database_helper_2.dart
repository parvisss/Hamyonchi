import 'package:exam_6/data/models/expense.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseHelper2 {
  final String tableName;
  DatabaseHelper2._internal({required this.tableName});

  static DatabaseHelper2? _instance;
  factory DatabaseHelper2({required String tableName}) {
    return _instance ??= DatabaseHelper2._internal(tableName: tableName);
  }

  static Database? _database;

  //! Create Table
  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, '$tableName.db');
    return await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      return db.execute('''
          CREATE TABLE $tableName (
            id TEXT PRIMARY KEY,
            category TEXT,
            summ TEXT,
            date TEXT,
            comment TEXT
          )
        '''); // Removed trailing comma
    });
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  //! Insert Expense into SQL
  Future<int> insertExpense(Expense expense) async {
    final db = await database;
    return await db.insert(
      tableName,
      expense.toMap(), // Call toMap() method
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //! Get all Expenses from SQL
  Future<List<Expense>> fetchExpenses() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Expense(
        id: maps[i]['id'],
        category: maps[i]['category'],
        summ: maps[i]['summ'],
        date: maps[i]['date'],
        comment: maps[i]['comment'],
      );
    });
  }

  //! Update Expense in SQL
  Future<int> updateExpense(Expense expense) async {
    final db = await database;
    return await db.update(
      tableName,
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //! Delete Expense from SQL
  Future<int> deleteExpense(String id) async {
    final db = await database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
