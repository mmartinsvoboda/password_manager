import 'package:password_manager/Models/password.dart';
import 'DbManager.dart';
import 'package:sqflite/sqflite.dart';

class PasswordDb {
  static const String table = "passwords";

  Future<List<Password>> getAllItems() async {
    var db = await DbManager().getPasswordManager();

    List<Map> maps = await db.rawQuery('SELECT * FROM $table ORDER BY name');

    print(maps);

    return List<Password>.generate(maps.length, (i) {
      return Password.withSecureStorageKey(
        maps[i]['id'],
        maps[i]['name'],
        maps[i]['account'],
        maps[i]['password'],
      );
    });
  }

  // Define a function that inserts into the database
  Future<void> insert(Password password) async {
    // Get a reference to the database.
    var db = await DbManager().getPasswordManager();

    await db.insert(
      table,
      password.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(Password password) async {
    // Get a reference to the database.
    var db = await DbManager().getPasswordManager();

    // Update the given Dog.
    await db.update(
      table,
      password.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [password.id],
    );
  }

  Future<void> delete(int id) async {
    // Get a reference to the database.
    var db = await DbManager().getPasswordManager();

    // Remove the Dog from the Database.
    await db.delete(
      table,
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
