import 'dart:async';
import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:toll_gate/models/vehicle_detail.dart';
import 'package:toll_gate/res/snackbar.dart';

import '../../models/vehicle_model.dart';
import 'dashboard.dart';

class RegisterVehicle extends StatefulWidget {
  @override
  RegisterVehicleState createState() {
    return RegisterVehicleState();
  }
}

Future<Vehicle> createVehicle(
  dynamic plate_no,
  String account_no,
  String rfid_tag_no,
  dynamic created_by,
) async {
  final String apiUrl = 'https://bridge-core.nssf.or.tz/vehicle/enroll-vehicle';//https://bridge-core.nssf.or.tz/vehicle/create
//  final String apiUrl = 'http://192.168.43.86/Ekanisa/web/vehicles';
  final response = await http.post(apiUrl,
      headers: {
        "content-type": "application/json",
      },
      body: jsonEncode({
        "account_no": account_no,
        "rfid_tag_no": rfid_tag_no,
        "plate_num": plate_no,
        "user_id": created_by
      }));
print(response.body);
  if (response.statusCode == 200) {
    final String responseString = response.body;
    print(responseString);
    return vehicleFromJson(responseString);
  } else {
    return null;
  }
}

class RegisterVehicleState extends State<RegisterVehicle> {
  Vehicle _vehicle;
  dynamic _mySelection;
  final String url = "https://bridge-core.nssf.or.tz/body-type/index";
  List data = List();

  Future<String> getBodyTypeList() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var resBody = json.decode(res.body);
    // print(resBody);

    setState(() {
      data = resBody;
    });

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    getVehicle();
    this.getBodyTypeList();
  }

  final _formKey = GlobalKey<FormState>();

  // final TextEditingController tag_numberController = TextEditingController();
  // final TextEditingController body_typeController = TextEditingController();
  // final TextEditingController account_numberController = TextEditingController();

  GlobalKey<AutoCompleteTextFieldState<VehicleDetail>> key = new GlobalKey();
  static List<VehicleDetail> vehicle = new List<VehicleDetail>();
  final TextEditingController plate_numberController = TextEditingController();
  AutoCompleteTextField searchTextField;

  bool loading = true;
  var vehicle_data;

//get vehicles
  void getVehicle() async {
    try {
      final response = await http.get("https://bridge-core.nssf.or.tz/vehicle");
      print(response.body);
      if (response.statusCode == 200) {
        vehicle = loadVehicles(response.body);
        print('Vehicles:${vehicle.length}');
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting Vehicles 1");
      }
    } catch (e) {
      print('Errors getting Vehicles');
    }
  }

  static List<VehicleDetail> loadVehicles(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    print(parsed);

    return parsed
        .map<VehicleDetail>((json) => VehicleDetail.fromJson(json))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final routes =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
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
                // TextFormField(
                //     controller: plate_numberController,
                //     decoration: InputDecoration(
                //       hintText: "Plate Number",
                //       prefixIcon: Icon(Icons.directions_car),
                //       border: const OutlineInputBorder(),
                //     ),
                //     validator: (value) {
                //       if (value.isEmpty) {
                //         return 'please enter something';
                //       }
                //       return null;
                //     }),
                // const SizedBox(height: 20.0),
                TextFormField(
                    // controller: account_numberController,
                    initialValue: routes['account'],
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
                const SizedBox(height: 20.0),
                Form(
                  child: Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        loading
                            ? CircularProgressIndicator()
                            : searchTextField =
                                AutoCompleteTextField<VehicleDetail>(
                                controller: plate_numberController,
                                key: key,
                                clearOnSubmit: false,
                                suggestions: vehicle,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      if (vehicle_data == null) {
                                        return false;
                                      }
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              '/account-details',
                                              arguments: {
                                            'vehicle': vehicle_data
                                          });
                                    },
                                    icon: Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    ),
                                  ),
                                  // contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                                  hintText: "Search Vehicle",
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                                itemFilter: (item, query) {
                                  return item.plate_no
                                      .toLowerCase()
                                      .startsWith(query.toLowerCase());
                                },
                                itemSorter: (a, b) {
                                  return a.plate_no.compareTo(b.plate_no);
                                },
                                itemSubmitted: (item) {
                                  setState(() {
                                    var data = {
                                      'plate_no': item.plate_no,
                                      'account_no': item.account_no
                                    };

                                    vehicle_data = json.encode(data);
                                    searchTextField.textField.controller.text =
                                        item.plate_no;
                                  });
                                },
                                itemBuilder: (context, item) {
                                  // ui for the autocompelete row
                                  return Container(
                                    padding: EdgeInsets.all(22),
                                    child: Row(
                                      children: [
                                        Text(
                                          item.plate_no,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        item.account_no == null
                                            ? Text(
                                                'NOT REGISTERED',
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            : Text(
                                                'ALREADY REGISTERED',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
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
                ),
                const SizedBox(height: 50.0),

                // DropdownButtonFormField(
                //   decoration: InputDecoration(
                //       hintText: "Body Type",
                //       prefixIcon: Icon(Icons.directions_car),
                //       border: const OutlineInputBorder()),
                //   validator: (value) {
                //     if (value.isEmpty) {
                //       return "Body Type Cant Be Empty";
                //     }
                //     return null;
                //   },
                //   items: data.map((item) {
                //     return new DropdownMenuItem(
                //       child: new Text(item['name']),
                //       value: item['id'].toString(),
                //     );
                //   }).toList(),
                //   onChanged: (newVal) {
                //     setState(() {
                //       _mySelection = newVal;
                //     });
                //   },
                //   value: _mySelection,
                // ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        print(_mySelection);
                        var user_id = await FlutterSession().get("user_id");

                        DateTime now = new DateTime.now();

                        final String account_no = routes['account'];
                        final dynamic plate_no = plate_numberController.text;
                        // final dynamic body_type_id = _mySelection;
                        final String rfid_tag_no = routes['barcode'];
                        final dynamic created_by = user_id;
                        final Vehicle vehicle = await createVehicle(
                          plate_no,
                          account_no,
                          rfid_tag_no,
                          created_by,
                        );
                        setState(() {
                          _vehicle = vehicle;
                        });
                        _vehicle == null
                            ? Scaffold.of(context).showSnackBar(BuildSnackbar()
                                .buildSnackBar(
                                    'Failed to Add! Please Check your Inputs'))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard(
                                        response:
                                            'Vehicle Added  Successfully')));
                      }
                    },
                    child: Text(
                      'ADD VEHICLE',
                      style: TextStyle(fontSize: 15),
                    ),
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
