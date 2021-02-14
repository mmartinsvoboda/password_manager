import 'package:flutter/material.dart';

/// The base class for the different types of items the list can contain.
/// Vytvoril jsem tuhle tridu, protoze jsem chtel na hlavni strance filtrovat
/// ruzne typy zaznamu, napriklad i kreditni karty. Ucel byl mit jednu
/// obecnou tridu, ze ktere pak budou vznikat dalsi a na zaklade toho
/// mit moznost filtrovat

abstract class MenuItem {
  String name;

  /// The title line to show in a list item.
  StatefulWidget menuItem(BuildContext context, String name, Function update);
}
