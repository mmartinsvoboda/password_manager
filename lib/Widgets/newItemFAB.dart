import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:password_manager/Pages/passwordForm.dart';

/// Tohle je FAB pro pridavani noveho zaznamu
/// Sel jsem touhle cestou, aby bylo jednoduche do budoucna pridat dalsi
/// popupy pro jine typy zaznamu

Widget newItemFAB(BuildContext context) {
  return SpeedDial(
    /// both default to 16
    marginEnd: 18,
    marginBottom: 20,
    // animatedIcon: AnimatedIcons.menu_close,
    // animatedIconTheme: IconThemeData(size: 22.0),
    /// This is ignored if animatedIcon is non null
    icon: Icons.add,
    activeIcon: Icons.remove,
    // iconTheme: IconThemeData(color: Colors.grey[50], size: 30),

    /// The label of the main button.
    // label: Text("Open Speed Dial"),
    /// The active label of the main button, Defaults to label if not specified.
    // activeLabel: Text("Close Speed Dial"),
    /// Transition Builder between label and activeLabel, defaults to FadeTransition.
    // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
    /// The below button size defaults to 56 itself, its the FAB size + It also affects relative padding and other elements
    buttonSize: 56.0,
    visible: true,

    /// If true user is forced to close dial manually
    /// by tapping main button and overlay is not rendered.
    closeManually: false,
    curve: Curves.bounceIn,
    overlayColor: Colors.black,
    overlayOpacity: 0.5,
    onOpen: () => print('OPENING DIAL'),
    onClose: () => print('DIAL CLOSED'),
    tooltip: 'Speed Dial',
    heroTag: 'speed-dial-hero-tag',
    backgroundColor: Colors.deepOrange[100],
    foregroundColor: Colors.purple[800],
    elevation: 8.0,
    shape: CircleBorder(),
    // orientation: SpeedDialOrientation.Up,
    // childMarginBottom: 2,
    // childMarginTop: 2,
    children: [
      SpeedDialChild(
        child: Icon(
          Icons.admin_panel_settings,
          color: Colors.purple[800],
        ),
        backgroundColor: Colors.deepOrange[100],
        label: 'Přidat heslo',
        labelStyle: TextStyle(fontSize: 18.0),
        onTap: () => Navigator.of(context)
            .push(new MaterialPageRoute<Null>(builder: (BuildContext context) {
          return PasswordForm();
        })),
      ),
    ],
  );
}
