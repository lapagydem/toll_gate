import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:toll_gate/models/user.dart';

class SearchAccount2 extends StatefulWidget {
  SearchAccount2() : super();

  final String title = "Search Account";

  @override
  _SearchAccountState createState() => _SearchAccountState();
}

class _SearchAccountState extends State<SearchAccount2> {
  AutoCompleteTextField searchTextField;
  var user_data;
  GlobalKey<AutoCompleteTextFieldState<User>> key = new GlobalKey();
  static List<User> users = new List<User>();
  bool loading = true;

  //get Accounts list with typahead
  void getUsers() async {
    try {
      final response =
          await http.get("https://bridge-core.nssf.or.tz/accounts");
      print(response.body);
      if (response.statusCode == 200) {
        users = loadUsers(response.body);
        print('Users:${users.length}');
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting Users");
      }
    } catch (e) {
      print('Errors getting Users');
    }
  }

  static List<User> loadUsers(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();

    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  Widget row(User user) {
    return Container(
      color: Colors.white,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            user.account_no,
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            user.first_name,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            loading
                ? CircularProgressIndicator()
                : searchTextField = AutoCompleteTextField<User>(
                    key: key,
                    clearOnSubmit: false,
                    suggestions: users,
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          // String data = item.first_name;
                          // print(data);
                          if (user_data == null) {
                            return false;
                          }
                          Navigator.of(context).pushReplacementNamed(
                              '/account-details',
                              arguments: {'user': user_data});
                        },
                        icon: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                      ),
                      // contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                      hintText: "Search Account",
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    itemFilter: (item, query) {
                      return item.account_no
                          .toLowerCase()
                          .startsWith(query.toLowerCase());
                    },
                    itemSorter: (a, b) {
                      return a.account_no.compareTo(b.account_no);
                    },
                    itemSubmitted: (item) {
                      setState(() {
                        var data = {
                          'first_name': item.first_name,
                          'account_number': item.account_no,
                          'middle_name': item.middle_name,
                          'surname': item.surname
                        };
                        user_data = json.encode(data);
                        searchTextField.textField.controller.text =
                            item.account_no;
                      });
                    },
                    itemBuilder: (context, item) {
                      // ui for the autocompelete row
                      return Container(
                        padding: EdgeInsets.all(22),
                        child: Row(
                          children: [
                            Text(
                              item.account_no,
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              item.first_name,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              item.middle_name,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              item.surname,
                            ),
                          ],
                        ),
                      );
                      // return row(item);
                    },
                  ),
          ],
        ),
      ),
    );
  }

  void route(BuildContext context, User item) {
    // Navigator.of(context).pushNamed('/account-details',arguments: {'user':item.first_name});
    String data = item.first_name;
    print(data);
    Navigator.of(context)
        .pushReplacementNamed('/account-details', arguments: {'user': data});
  }
}
