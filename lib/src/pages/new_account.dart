import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toll_gate/src/pages/dashboard.dart';
import 'package:toll_gate/res/snackbar.dart';

import '../../models/account_model.dart';
import 'account_form.dart';

class NewAccount extends StatefulWidget {
  @override
  _NewAccountState createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {
  BuildSnackbar snackbar;

  @override
  Widget build(BuildContext context) {
    final routes = ModalRoute.of(context).settings.arguments as Map<String, String>;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text(routes['title']),
          centerTitle: true,
        ),
      body: RegisterAccount(),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        color: Colors.orangeAccent,
        child: Container(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0),
                icon: Icon(Icons.dashboard),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed('/', arguments: {});
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(Icons.account_circle),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

TextField _buildTextField({bool obscureText = false}) {
  return TextField(
    obscureText: obscureText,
  );
}


