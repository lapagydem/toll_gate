import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:toll_gate/models/account.dart';

class Dashboard extends StatefulWidget {
  final response;
  Dashboard({this.response});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  PageController _myPage = PageController(initialPage: 0);
  final TextStyle whiteText = TextStyle(color: Colors.white);
  final TextStyle BlackText = TextStyle(color: Colors.black);
  bool status = false;
  static String res;
  static List<Account> users = new List<Account>();
  bool loading = true;

  @override
  final String url = "https://bridge-core.nssf.or.tz/auth-users/";
  var first_name;
  var surname;
  String user_data = '';
  String email = '';

  //get Users list with typahead
  void getUsersData() async {
    try {
      var user_id = await FlutterSession().get("user_id");
      first_name = await FlutterSession().get("first_name");
      surname = await FlutterSession().get("surname");
      email = await FlutterSession().get("email");
      setState(() {
        user_data = first_name + ' ' + surname;
        email = email;
      });
      print(surname);
      print(first_name);

      final response = await http.get(Uri.encodeFull(url + user_id),
          headers: {"Accept": "application/json"});

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

  void initState() {
    // TODO: implement initState
    res = widget.response;
    // saveData();
    super.initState();
    checkResponse();
    getUsersData();
  }

  static List<Account> loadUsers(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();

    return parsed.map<Account>((json) => Account.fromJson(json)).toList();
  }

  checkResponse() {
    if (res == ' ') {
      setState(() {
        status = false;
      });
    } else {
      setState(() {
        status = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    // var data = arguments['resData'];
    // print(data);
    // user_name =
    //     data['first_name'] + ' ' + data['middle_name'] + ' ' + data['surname'];

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: _buildBody(context),
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
                  setState(() {
                    _myPage.jumpToPage(0);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(3);
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    // BoxDecoration(
    //     image: DecorationImage(
    //         image: AssetImage('assets/image/nss.png'), fit: BoxFit.cover));
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(),
          status
              ? AlertDialog(
                  backgroundColor: Colors.green,
                  content: Column(
                    children: <Widget>[
                      FlatButton(
                        child: Text(
                          status ? res : ' ',
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/dashboard');
                        },
                      ),
                    ],
                  ),
                )
              : Container(),
//          Container(
//            child: Text(
//                status ? res : ' '
//            ),
//          ),
          Card(
            elevation: 5.0,
            color: Colors.white,
            margin: const EdgeInsets.all(20.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: _buildTile(
                    color: Colors.blueAccent,
                    icon: Icons.directions_car,
                    title: "Total Registered Vehicles",
                    data: "1200",
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildTile(
                    color: Colors.green,
                    icon: Icons.portrait,
                    title: "Total Accounts",
                    data: "857",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(width: 20.0),
                Flexible(
                  child: ButtonTheme(
                    minWidth: 100.0,
                    height: 110.0,
                    child: RaisedButton(
                      color: Colors.amber[50],
                      elevation: 5.0,
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.person_add,
                                size: 40,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Account",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/new-account');
                      },
                    ),
                  ),
                ),
                SizedBox(width: 5.0),
                Flexible(
                  child: ButtonTheme(
                    minWidth: 100.0,
                    height: 110.0,
                    child: RaisedButton(
                      color: Colors.amber[50],
                      elevation: 5.0,
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.directions_car,
                              size: 40,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Vehicle",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        // Navigator.of(context)
                        //     .pushReplacementNamed('/scanner', arguments: {});
                      },
                    ),
                  ),
                ),
                SizedBox(width: 5.0),
                ButtonTheme(
                  minWidth: 100.0,
                  height: 110.0,
                  child: RaisedButton(
                    color: Colors.amber[50],
                    elevation: 5.0,
                    padding: EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.fiber_new,
                            size: 50,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Enrollment",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/account');
                    },
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 50.0, 0, 32.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        color: Colors.orangeAccent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              "Dashboard",
              style: whiteText.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            // trailing: CircleAvatar(
            //   radius: 25.0,
            // ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              user_data,
              style: BlackText.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              email,
              style: BlackText,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildTile(
      {Color color, IconData icon, String title, String data}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 150.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            title,
            style: whiteText.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            data,
            style:
                whiteText.copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}
