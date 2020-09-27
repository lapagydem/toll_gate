import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toll_gate/res/snackbar.dart';

import '../../models/account_model.dart';
import 'dashboard.dart';

class RegisterAccount extends StatefulWidget {
  @override
  RegisterAccountState createState() {
    return RegisterAccountState();
  }
}

Future<AccountModel> createAccount(
  String nida,
  String first_name,
  String middle_name,
  String surname,
  String phone,
  String email,
) async {
  final String apiUrl = 'http://10.10.13.76/smart-pass/web/accounts';
//  final String apiUrl = 'http://192.168.43.86/Ekanisa/web/vehicles';
  final response = await http.post(apiUrl, body: {
    "nida": nida,
    "first_name": first_name,
    "middle_name": middle_name,
    "surname": surname,
    "email": email,
    "phone": phone
  });
  if (response.statusCode == 201) {
    final String responseString = response.body;
    return accountModelFromJson(responseString);
  } else {
    return null;
  }
}

class RegisterAccountState extends State<RegisterAccount> {
  AccountModel _account;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nidaController = TextEditingController();
  final TextEditingController first_nameController = TextEditingController();
  final TextEditingController middle_nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

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
                TextFormField(
                    controller: first_nameController,
                    decoration: InputDecoration(
                      hintText: "First Name",
                      prefixIcon: Icon(Icons.person_outline),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter Your First Name';
                      }
                      return null;
                    }),
                const SizedBox(height: 20.0),
                TextFormField(
                    controller: middle_nameController,
                    decoration: InputDecoration(
                      hintText: "Middle Name",
                      prefixIcon: Icon(Icons.person),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter your middle name";
                      }
                      return null;
                    }),
                const SizedBox(height: 20.0),
                TextFormField(
                    controller: surnameController,
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      prefixIcon: Icon(Icons.person),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter Your Last name';
                      }
                      return null;
                    }),
                const SizedBox(height: 20.0),
                TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      prefixIcon: Icon(Icons.account_balance_wallet),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter your phone number';
                      }
                      return null;
                    }),
                const SizedBox(height: 20.0),
                TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.mail),
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
                    controller: nidaController,
                    decoration: InputDecoration(
                      hintText: "NIDA number",
                      prefixIcon: Icon(Icons.nfc),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter your NIDA number';
                      }
                      return null;
                    }),
                const SizedBox(height: 20.0),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        final String nida = nidaController.text;
                        final String first_name = first_nameController.text;
                        final String middle_name = middle_nameController.text;
                        final String surname = surnameController.text;
                        final String phone = phoneController.text;
                        final String email = emailController.text;
                        final AccountModel account = await createAccount(nida,
                            first_name, middle_name, surname, phone, email);

                        setState(() {
                          _account = account;
                        });

                        _account == null
                            ? Scaffold.of(context).showSnackBar(BuildSnackbar()
                                .buildSnackBar(
                                    'Failed to Register! Please Check your Inputs'))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard(
                                        response:
                                            'Account of ${_account.firstName} was Created Successfully')));
                        //                    : Text(" Owner ${_account.firstName},${_account.middleName} is created succesfullly "),

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
