import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Pages/mainPage.dart';

Future<void> main() async {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PasswordManager(),
    ));
}

