import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/Models/password.dart';
import 'package:password_manager/Pages/passwordForm.dart';
import 'package:password_manager/Tools/biometrics.dart';
import 'package:toast/toast.dart';

class MenuItemWidget extends StatefulWidget {
  final Password password;
  final Function update;

  MenuItemWidget({this.password, this.update});

  @override
  _MenuItemWidgetState createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(new MaterialPageRoute<Null>(builder: (BuildContext context) {
        return PasswordForm(password: widget.password);
      })),
      child: Card(
        color: Colors.grey[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 0,
              child: Container(
                  margin: EdgeInsets.all(12), child: widget.password.icon),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.password.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.purple[800],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.password.account,
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.grey[600]),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                margin: EdgeInsets.all(2),
                child: IconButton(
                  icon: const Icon(
                    Icons.copy,
                    color: Colors.purple,
                    size: 25,
                  ),
                  onPressed: () async {
                    if (await Biometrics.canCheckBiometrics()) {
                      await Biometrics.getListOfBiometricTypes();
                      if (await Biometrics.authenticateUser()) {
                        await widget.password.copyFunction();
                        widget.update();
                        Toast.show("Úspěšně zkopírováno do schránky", context,
                            duration: 5, gravity: Toast.BOTTOM);
                        return;
                      }

                      Toast.show("Nelze ověřit biometriku.", context,
                          duration: 5, gravity: Toast.BOTTOM);
                      return;
                    }
                  },
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.purple,
                    size: 25,
                  ),
                  onPressed: () async {
                    await widget.password.deleteFunction();
                    widget.update();
                    Toast.show("Úspěšně odebráno", context,
                        duration: 5, gravity: Toast.BOTTOM);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
