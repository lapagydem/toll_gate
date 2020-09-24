import 'package:flutter/material.dart';

class BuildSnackbar  {
  SnackBar buildSnackBar(String message) {
    return SnackBar(
      content: Row(
        children: <Widget>[
          Icon(Icons.error),
          SizedBox(width: 10),
          Expanded(
            child: Text( message
            ),
          )
        ],
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }
}

  