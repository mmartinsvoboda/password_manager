import 'package:flutter/material.dart';
import 'package:password_manager/Models/password.dart';
import 'package:toast/toast.dart';

class PasswordForm extends StatefulWidget {
  final Password password;

  PasswordForm({this.password});

  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>();

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final nameController = TextEditingController();
  final accountController = TextEditingController();
  final passwordController = TextEditingController();

  var pridavam = true;
  var topText = "Nové heslo";
  var buttonText = "Přidat";


  @override
  initState() {
    super.initState();
    if (widget.password != null) {
      nameController.text = widget.password.name;
      accountController.text = widget.password.account;

      new Future<String>.delayed(new Duration(seconds: 2), () async => await widget.password.getPasswordFromSecureStorage()).then((String value) {
        setState(() {
          passwordController.text = value;
        });
      });

      topText = "Úprava hesla";
      buttonText = "Upravit";
      pridavam = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[900],
      appBar: AppBar(backgroundColor: Colors.purple[900], elevation: 0),
      body: SafeArea(
        child: Column(
          verticalDirection: VerticalDirection.down,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                topText,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[50],
                    letterSpacing: 1.1),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Název",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.purple[900]),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                              child: TextFormField(
                                controller: nameController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Tohle je potřeba vyplnit';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Text(
                              "Uživatelské jméno",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.purple[900]),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                              child: TextFormField(
                                controller: accountController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Tohle je potřeba vyplnit';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Text(
                              "Heslo",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.purple[900]),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: passwordController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Tohle je potřeba vyplnit';
                                      }
                                      return null;
                                    },
                                    obscureText: _obscureText,
                                  ),
                                  new FlatButton(
                                      onPressed: _toggle,
                                      child: new Text(_obscureText
                                          ? "Zobraz heslo"
                                          : "Skrýt heslo"))
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.pressed))
                                        return Colors.purple[800];
                                      return Colors.purple[
                                          900]; // Use the component's default.
                                    },
                                  ),
                                ),
                                onPressed: () async {
                                  // Validate returns true if the form is valid, or false
                                  // otherwise.
                                  if (_formKey.currentState.validate()) {
                                    // If the form is valid
                                    if (pridavam) {
                                      var newPassword = Password(
                                          null,
                                          nameController.text,
                                          accountController.text);
                                      await newPassword
                                          .savePasswordToSecureStorage(
                                              passwordController.text);
                                      await newPassword.addToDb();
                                      Navigator.pop(context);
                                      Toast.show("Úspěšně přidáno", context,
                                          duration: 5, gravity: Toast.BOTTOM);
                                    } else {
                                      widget.password.name =
                                          nameController.text;
                                      widget.password.account =
                                          accountController.text;
                                      await widget.password
                                          .savePasswordToSecureStorage(
                                              passwordController.text);
                                      await widget.password.updateInDb();
                                      Toast.show("Úspěšně upraveno", context,
                                          duration: 5, gravity: Toast.BOTTOM);
                                    }
                                  }
                                },
                                child: Text(buttonText),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
