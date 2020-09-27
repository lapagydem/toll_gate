import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toll_gate/models/user.dart';

import 'new_account_tab.dart';

class SearchAccount extends StatefulWidget {
  SearchAccount() : super();

  final String title = "Search Account";
  @override
  _SearchAccountState createState() => _SearchAccountState();
}

class _SearchAccountState extends State<SearchAccount> {
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<User>> key = new GlobalKey();
  static List<User> users = new List<User>();
  bool loading = true;

  static List<User> loadUsers(String jsonString){
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();

    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }
  @override
  void initState() {
    super.initState();
  }

  @override

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          extendBody: false,
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

                    },
                  ),
                  IconButton(
                    iconSize: 30.0,
                    padding: EdgeInsets.only(right: 28.0),
                    icon: Icon(Icons.account_circle),
                    onPressed: () {

                    },
                  )
                ],
              ),
            ),
          ),

          appBar: AppBar(
            backgroundColor: Colors.orangeAccent,
            title: TabBar(tabs: [
              Tab(text: 'Existing Account'),
              Tab(text: 'New Account')
            ]),
          ),
          body: TabBarView(children: [
            // NavigationExample(),
            SearchAccount2(),
            SearchAccount2(),
          ])),
    );

  }
}
