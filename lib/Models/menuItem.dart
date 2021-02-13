import 'package:flutter/material.dart';

/// The base class for the different types of items the list can contain.
abstract class MenuItem {
  String name;
  /// The title line to show in a list item.
  StatefulWidget menuItem(BuildContext context, String name, Function update);
}