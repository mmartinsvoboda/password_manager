import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Hlavni manazer databaze
/// Primarni ucel je ziskat pristup k databazi a pri prvnim spusteni databazi
/// vytvorit
class DbManager {
  Database database;

  Future<Database> getPasswordManager() async {
    if (database != null) return database;

    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'database.db');

    database = await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE passwords (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, account TEXT, password TEXT)');
      await db.execute(
          'CREATE TABLE credit_cards (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, cardNumber TEXT, expirationDate TEXT, cvcCode TEXT)');
    });

    return database;
  }
}
