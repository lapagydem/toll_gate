import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/vehicle_model.dart';

class VehicleRegistration extends StatefulWidget {
  @override
  _VehicleRegistrationState createState() => _VehicleRegistrationState();
}

class _VehicleRegistrationState extends State<VehicleRegistration> {
  @override
  Widget build(BuildContext context) {
    final routes =
    ModalRoute
        .of(context)
        .settings
        .arguments as Map<String, String>;

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

