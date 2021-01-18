import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toll_gate/src/pages/vehicle_form.dart';

class VehicleRegistration extends StatefulWidget {
  @override
  _VehicleRegistrationState createState() => _VehicleRegistrationState();
}

class _VehicleRegistrationState extends State<VehicleRegistration> {
  @override
  Widget build(BuildContext context) {
    final routes =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(
          routes['title'],
          style: TextStyle(fontSize: 15, fontStyle: FontStyle.normal),
        ),
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
