import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/Database/PasswordDb.dart';
import 'package:password_manager/Models/menuItem.dart';
import 'package:password_manager/Widgets/menuItemWidget.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Password implements MenuItem {
  int id;
  String name;
  String account;
  String secureStorageKey;
  Function update;

  Icon icon = Icon(
    Icons.admin_panel_settings,
    color: Colors.purple[800],
    size: 50,
  );

  Password(int id, String name, String account) {
    this.id = id;
    this.name = name;
    this.account = account;
  }

  Password.withSecureStorageKey(int id, String name, String account, String secureStorageKey) {
    this.id = id;
    this.name = name;
    this.account = account;
    this.secureStorageKey = secureStorageKey;
  }

  Future<String> getPasswordFromSecureStorage() async {
    // Create storage
    final storage = new FlutterSecureStorage();

    var password = await storage.read(key: secureStorageKey);
    print(password);
    // Write value
    return password;
  }

  Future<void> savePasswordToSecureStorage(String newPassword) async {
    // Create storage
    final storage = new FlutterSecureStorage();
    await createSecureStorageKey();

    print(newPassword);

    // Write value
    await storage.write(key: secureStorageKey, value: newPassword);
  }

  Future<void> createSecureStorageKey() async {
    if(secureStorageKey != null) return;

    var base = name + '_' + account;
    var locKey = base;

    // Create storage
    final storage = new FlutterSecureStorage();
    String value = await storage.read(key: base);
    int i = 0;

    while (value != null) {
      i++;
      locKey = base + i.toString();
      value = await storage.read(key: locKey);
    }

    secureStorageKey = locKey;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'account': account,
      'password': secureStorageKey
    };
  }

  Future<void> copyFunction() async {
    var password = await getPasswordFromSecureStorage();
    print(password);
    Clipboard.setData(new ClipboardData(text: password));
  }

  deleteFunction() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: secureStorageKey);
    await PasswordDb().delete(id);
  }

  addToDb() async {
    await PasswordDb().insert(this);
  }

  updateInDb() async {
    await PasswordDb().update(this);
  }

  StatefulWidget menuItem(BuildContext context, name, Function _update) {
    return MenuItemWidget(password: this, update: _update);
  }
}
