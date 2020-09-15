import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/vehicle_model.dart';

class RegisterVehicle extends StatefulWidget {
  @override
  RegisterVehicleState createState() {
    return RegisterVehicleState();
  }
}

Future<VehicleModel> createVehicle(String plate_no, String account_no,
    String rfid_tag_no, String body_type_id) async {
  final String apiUrl = 'http://10.10.13.76/Ekanisa/web/vehicles';
//  final String apiUrl = 'http://192.168.43.86/Ekanisa/web/vehicles';
  final response = await http.post(apiUrl, body: {
    "body_type_id": body_type_id,
    "account_no": account_no,
    "rfid_tag_no": rfid_tag_no,
    "plate_no": plate_no
  });

  if (response.statusCode == 201) {
    final String responseString = response.body;
    print(responseString);
    return vehicleModelFromJson(responseString);
  } else {
    return null;
  }
}
class RegisterVehicleState extends State<RegisterVehicle> {
  VehicleModel _vehicle;
  String _mySelection;
  final String url = "http://10.10.13.76/smart-pass/web/body";
  List data = List(); //edited line

  Future<String> getBodyTypeList() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getBodyTypeList();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController tag_numberController = TextEditingController();
  final TextEditingController body_typeController = TextEditingController();
  final TextEditingController account_numberController = TextEditingController();
  final TextEditingController plate_numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final routes =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.yellow[100],

      body: Container(
        margin: const EdgeInsets.fromLTRB(16.0, 20.0, 18.0, 16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), color: Colors.white),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20.0),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      hintText: "Body Type",
                      prefixIcon: Icon(Icons.directions_car),
                      border: const OutlineInputBorder()),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Body Type Cant Be Empty";
                    }
                    return null;
                  },
                  items: data.map((item) {
                    return new DropdownMenuItem(
                      child: new Text(item['name']),
                      value: item['id'].toString(),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      _mySelection = newVal;
                    });
                  },
                  value: _mySelection,
                ),
                const SizedBox(height: 20.0),
                TextFormField(
//                    controller: tag_numberController,
                    initialValue: routes['barcode'],
                    decoration: InputDecoration(
                      hintText: "Tag Number",
                      prefixIcon: Icon(Icons.apps),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Tag Number Can't be Empty";
                      }
                      return null;
                    }),
                const SizedBox(height: 20.0),
                TextFormField(
                    controller: plate_numberController,
                    decoration: InputDecoration(
                      hintText: "Plate Number",
                      prefixIcon: Icon(Icons.directions_car),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter something';
                      }
                      return null;
                    }),
                const SizedBox(height: 20.0),
                TextFormField(
                    controller: account_numberController,
                    decoration: InputDecoration(
                      hintText: "Account Number",
                      prefixIcon: Icon(Icons.account_balance_wallet),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter something';
                      }
                      return null;
                    }),
                _vehicle == null
                    ? Container()
                    : Text(
                        " Owner is created succesfullly with vehicle "),
                const SizedBox(height: 20.0),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        final String account_no =
                            account_numberController.text;
                        final String body_type_id = body_typeController.text;
                        final String plate_no = plate_numberController.text;
                        final String rfid_tag_no = routes['barcode'];
                        final VehicleModel vehicle = await createVehicle(
                            body_type_id,
                            account_no,
                            rfid_tag_no,
                            plate_no);

                        setState(() {
                          _vehicle = vehicle;
                        });
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Registering'),
                        ));
                      }
                    },
                    child: Text('Register'),
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),

//      body: new Center(
//      child: new DropdownButton(
//        items: data.map((item) {
//          return new DropdownMenuItem(
//            child: new Text(item['item_name']),
//            value: item['id'].toString(),
//          );
//        }).toList(),
//        onChanged: (newVal) {
//          setState(() {
//            _mySelection = newVal;
//          });
//        },
//        value: _mySelection,
//      ),
//    ),
    );
  }
}
