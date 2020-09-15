import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toll_gate/res/colors.dart';

import '../../models/vehicle_model.dart';

class NewAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routes =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(routes['title']),
      ),
      body: RegisterVehicle(),
    );
  }
}

TextField _buildTextField({bool obscureText = false}) {
  return TextField(
    obscureText: obscureText,
  );
}

class RegisterVehicle extends StatefulWidget {
  @override
  RegisterVehicleState createState() {
    return RegisterVehicleState();
  }
}

Future<VehicleModel> createVehicle(
    String first_name,
    String last_name,
    String email,
    String phone_number,
    String national_id,
    String tag_number,
    String plate_number) async {
  final String apiUrl = 'http://192.168.43.86/Ekanisa/web/vehicles';
  final response = await http.post(apiUrl, body: {
    "first_name": first_name,
    "last_name": last_name,
    "email": email,
    "phone_number": phone_number,
    "national_id": national_id,
    "tag_number": tag_number,
    "plate_number": plate_number
//        "name": name,
//        "job": jobTitle
  });
  if (response.statusCode == 201) {
    final String responseString = response.body;
    return vehicleModelFromJson(responseString);
  } else {
    return null;
  }
}

class RegisterVehicleState extends State<RegisterVehicle> {
  VehicleModel _vehicle;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController first_nameController = TextEditingController();
  final TextEditingController lat_nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phone_numberController = TextEditingController();
  final TextEditingController national_idController = TextEditingController();
  final TextEditingController tag_numberController = TextEditingController();
  final TextEditingController plate_numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final routes =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    // TODO: implement build
    return Scaffold(
      backgroundColor: mainBg,
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
                    controller: first_nameController,
                    decoration: InputDecoration(
                      hintText: "First Name",
                      prefixIcon: Icon(Icons.person),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter First Name';
                      }
                      return null;
                    }),
                const SizedBox(height: 20.0),
                TextFormField(
                    controller: lat_nameController,
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      prefixIcon: Icon(Icons.person),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter Last Name';
                      }
                      return null;
                    }),
                const SizedBox(height: 20.0),
                TextFormField(
                    controller: national_idController,
                    decoration: InputDecoration(
                      hintText: "National ID",
                      prefixIcon: Icon(Icons.storage),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter National ID';
                      }
                      return null;
                    }),
                const SizedBox(height: 20.0),
                TextFormField(
                    controller: phone_numberController,
                    decoration: InputDecoration(
                      hintText: "Mobile Number",
                      prefixIcon: Icon(Icons.phone),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter Phone Number';
                      }
                      return null;
                    }),
                const SizedBox(height: 20.0),
                TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter your Email';
                      }
                      return null;
                    }),
                const SizedBox(height: 20.0),
                TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Body Type",
                      prefixIcon: Icon(Icons.directions_car),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter Car body type';
                      }
                      return null;
                    }),
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
                _vehicle == null
                    ? Container()
                    : Text(
                        " Owner ${_vehicle.firstName},${_vehicle.lastName} is created succesfullly with vehicle "),
                const SizedBox(height: 20.0),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        final String first_name = first_nameController.text;
                        final String last_name = lat_nameController.text;
                        final String email = emailController.text;
                        final String phone_number = phone_numberController.text;
                        final String national_id = national_idController.text;
                        final String tag_number = routes['barcode'];
                        final String plate_number = plate_numberController.text;
                        final VehicleModel vehicle = await createVehicle(
                            first_name,
                            last_name,
                            email,
                            phone_number,
                            national_id,
                            tag_number,
                            plate_number);

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
    );
  }
}
