import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;

import 'data.dart';

class MyMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_typeahead demo',
      home: MyHomePage2(),
    );
  }
}

class MyHomePage2 extends StatelessWidget {
  final String url = "https://bridge-core.nssf.or.tz/accounts";
  List data = List();

  Future<String> getAccounts() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var resBody = json.decode(res.body);
    print(resBody);

      data = resBody;


    return "Sucess";
  }

  @override
  void initState() {
    this.getAccounts();
  }

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
            FormExample(),
            ScrollExample(),
          ])),
    );
  }
}


class FormExample extends StatefulWidget {
  @override
  _FormExampleState createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();

  String _selectedCity;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: this._formKey,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                decoration: InputDecoration(labelText: 'Account',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: (){
                      if (this._formKey.currentState.validate()) {
                        this._formKey.currentState.save();
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content:
                            Text('Your Favorite City is ${this._selectedCity}'),
                          ),

                        );
                      }
                    },
                    icon: Icon(Icons.check_circle, color: Colors.black),

                  ),

                ),

                controller: this._typeAheadController,
              ),
              suggestionsCallback: (pattern) {

                return CitiesService.getSuggestions(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSuggestionSelected: (suggestion) {
                this._typeAheadController.text = suggestion;
              },
              validator: (value) =>
                  value.isEmpty ? 'Please select a city' : null,
              onSaved: (value) => this._selectedCity = value,
            ),
            SizedBox(
              height: 10.0,
            ),
            // RaisedButton(
            //   // textColor: Colors.white,
            //   // color: Colors.green,
            //   // padding: const EdgeInsets.all(8.0),
            //   // child: Text('Submit'),
            //   onPressed: () {
            //     if (this._formKey.currentState.validate()) {
            //       this._formKey.currentState.save();
            //       Scaffold.of(context).showSnackBar(
            //         SnackBar(
            //           content:
            //               Text('Your Favorite City is ${this._selectedCity}'),
            //         ),
            //       );
            //     }
            //   },
            // )
          ],
        ),
      ),
    );
  }
}

class ScrollExample extends StatelessWidget {
  final List<String> items = List.generate(5, (index) => "Item $index");

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Suggestion box will resize when scrolling"),
        ),
      ),
      SizedBox(height: 200),
      TypeAheadField<String>(
        getImmediateSuggestions: true,
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'What are you looking for?'),
        ),
        suggestionsCallback: (String pattern) async {
          final String url = "http://10.10.47.43/to_dev/tgmis_rest_api/web/accounts";
          List data = List();
          var res = await http
              .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

          var resBody = json.decode(res.body);
          print(resBody);

          return items
              .where((item) =>
              item.toLowerCase().startsWith(pattern.toLowerCase()))
              .toList();
        },
        itemBuilder: (context, String suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        onSuggestionSelected: (String suggestion) {
          print("Suggestion selected");
        },
      ),
      SizedBox(height: 500),
    ]);
  }
}

class ProductPage extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductPage({this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Text(
              this.product['name'],
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              this.product['price'].toString() + ' USD',
              style: Theme.of(context).textTheme.subtitle1,
            )
          ],
        ),
      ),
    );
  }
}
