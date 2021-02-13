import 'package:flutter/material.dart';
import 'package:password_manager/Database/PasswordDb.dart';
import 'package:password_manager/Models/menuItem.dart';
import 'package:password_manager/Widgets/newItemFAB.dart';

class PasswordManager extends StatefulWidget {
  @override
  _PasswordManagerState createState() => _PasswordManagerState();
}

class _PasswordManagerState extends State<PasswordManager> {

  List<MenuItem> data = List();

  void _update() {
    setState((){});
  }

  @override
  initState() {
    super.initState();

    new Future<List<MenuItem>>.delayed(new Duration(seconds: 2), () async => await PasswordDb().getAllItems()).then((List<MenuItem> value) {
      setState(() {
        value.sort((a,b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    new Future<List<MenuItem>>.delayed(new Duration(seconds: 2), () async => await PasswordDb().getAllItems()).then((List<MenuItem> value) {
      setState(() {
        value.sort((a,b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        data = value;
      });
    });

    return Scaffold(
        backgroundColor: Colors.purple[900],
        appBar: AppBar(
          title: Text("Správce hesel"),
          centerTitle: true,
          backgroundColor: Colors.purple[900],
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
            tooltip: "Menu",
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.face),
              onPressed: () {},
              tooltip: "Profil",
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            verticalDirection: VerticalDirection.down,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  margin: EdgeInsets.all(12),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.all(
                      Radius.circular(14),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText: "Hledat",
                            hintStyle: TextStyle(
                              color: Colors.black.withAlpha(120),
                            ),
                            border: InputBorder.none,
                          ),
                          onChanged: (String keyword) {},
                        ),
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.black.withAlpha(120),
                      )
                    ],
                  )),
              Expanded(
                flex: 0,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(12),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange[100],
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        child: Text(
                          "Všechny kategorie",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.purple[800],
                              fontSize: 16),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        child: Text(
                          "Hesla",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        child: Text(
                          "Osobní údaje",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    scrollDirection: Axis.vertical,
                    // controller: _controller,
                    // physics: const AlwaysScrollableScrollPhysics(),
                    children: data.map((i) {
                      return i.menuItem(context, i.name, _update);
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: newItemFAB(context));
  }
}
