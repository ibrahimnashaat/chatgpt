import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    print('Database initialization');
    String path = join(await getDatabasesPath(), 'chat_database.db');
    print('Database path: $path');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        print('Upgrading database from version $oldVersion to $newVersion');
        // Perform database schema upgrades here if needed
      },
      onOpen: (Database db) async {
        print('Database opened');
      },
    );
  }

  Future<void> _createDb(Database db, int version) async {
    try {
      await db.execute('''
      CREATE TABLE chat_messages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        text TEXT,
        messageType TEXT
      )
    ''');
      print('Table created: chat_messages');
    } catch (e) {
      print('Error creating table: $e');
    }
  }

  // Delete the database
  Future<void> deleteDatabase() async {
    String path = join(await getDatabasesPath(), 'chat_database.db');
    await databaseFactory.deleteDatabase(path);
    _database = null;
    print('Database deleted');
  }
  Future<int> insertMessage(String text, String messageType) async {
    Database db = await instance.database;
    try {
      int result = await db.insert('chat_messages', {'text': text, 'messageType': messageType});
      print('Inserted message: $result');
      return result;
    } catch (e) {
      print('Error inserting message: $e');
      return -1; // or any other value to indicate an error
    }
  }

  Future<List<Map<String, dynamic>>> getMessages() async {
    Database db = await instance.database;
    return await db.query('chat_messages');
  }
}