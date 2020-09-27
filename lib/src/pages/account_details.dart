import 'dart:convert';

import 'package:flutter/material.dart';

class AccountDetails extends StatefulWidget {
  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  final TextStyle whiteText = TextStyle(color: Colors.white);
  final TextStyle BlackText =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
  var user;
  var account_no;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    var data = arguments['user'];
    var decoded = json.decode(data);
    user = decoded['first_name'] +
        ' ' +
        decoded['middle_name'] +
        ' ' +
        decoded['surname'];
    account_no = decoded['account_number'];
    print(decoded['first_name']);

    if (arguments != null) print(arguments['user']);
    print(data);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        // title: Text('Account Details'),
      ),
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
                onPressed: () {},
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

  Widget _buildBody(BuildContext context) {
    BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/image/nss.png'), fit: BoxFit.cover));
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(),
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
                  flex: 1,
                  child: _buildTile(
                    color: Colors.blueAccent,
                    icon: Icons.monetization_on,
                    title: "Account Balance",
                    data: "50,000/=",
                  ),
                ),
                const SizedBox(width: 13.0),
                Expanded(
                  child: _buildTile(
                    color: Colors.green,
                    icon: Icons.directions_car,
                    title: "Number of Vehicles",
                    data: "5",
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
                ButtonTheme(
                  minWidth: 120.0,
                  height: 110.0,
                  child: RaisedButton(
                    color: Colors.white,
                    elevation: 5.0,
                    padding: EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.attach_money,
                            size: 50,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Payments",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 8.0),
                ButtonTheme(
                  minWidth: 120.0,
                  height: 110.0,
                  child: RaisedButton(
                    color: Colors.white,
                    elevation: 5.0,
                    padding: EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.directions_car,
                            size: 50,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "New Vehicle",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/new-vehicle', arguments: {});
                    },
                  ),
                ),
                SizedBox(width: 8.0),
                ButtonTheme(
                  minWidth: 120.0,
                  height: 110.0,
                  child: RaisedButton(
                    color: Colors.white,
                    elevation: 5.0,
                    padding: EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.settings,
                            size: 50,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Settings",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 20.0),
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
              "Account Profile",
              style: whiteText.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            trailing: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/image/user2.png'),

              // child: Image.asset('assets/image/nss.png'),
              radius: 25.0,
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              user.toUpperCase(),
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
              "Account no: " + account_no,
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
