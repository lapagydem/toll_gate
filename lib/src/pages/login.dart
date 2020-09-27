import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;
import 'package:toll_gate/res/users.dart';

import 'dashboard.dart';

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String> _loginUser(LoginData data) async {
    final String apiUrl =
        'http://10.10.47.43/to_dev/tgmis_rest_api/web/auth-user/login';
    final response = await http
        .post(apiUrl, body: {"username": data.name, "password": data.password});
    print(response.statusCode);
    var newsData = await response.body;
    var decoded = json.decode(response.body);
    print(decoded['message']);
    if (decoded['message'] == 'Authenticated') {
      // final String responseString = response.body;
      print(newsData);
      // print(response.body);
      return null;
    } else {
      return 'username or password did not match';
    }
  }
// for testing login localy
//   Future<String> _loginUser(LoginData data) {
//     return Future.delayed(loginTime).then((_) {
//       if (!mockUsers.containsKey(data.name)) {
//         return 'Username not exists';
//       }
//       if (mockUsers[data.name] != data.password) {
//         return 'Password does not match';
//       }
//       return null;
//     });
//   }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'BCMS',
      messages: LoginMessages(
        usernameHint: 'Username',
        passwordHint: 'Password',
        confirmPasswordHint: 'Confirm',
        loginButton: 'LOG IN',
        signupButton: '',
        recoverPasswordSuccess: 'Password rescued successfully',
      ),
      emailValidator: (value) {
        return null;
      },

      logo: 'assets/image/nssf.png',
      onLogin: (loginData) {
        print('Login info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        return _loginUser(loginData);
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Dashboard(response: ' '),
        ));
      },
      onRecoverPassword: (_) => Future(null),
      theme: LoginTheme(primaryColor: Colors.orangeAccent,
    titleStyle: TextStyle(
        color: Colors.white,
        fontFamily: 'Quicksand',
        fontSize: 25,
        letterSpacing: 4,
      ),

      ),

    );

  }
}
