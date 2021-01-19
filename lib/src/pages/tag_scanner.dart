import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';


class TagScanner extends StatefulWidget {

  final response;


  TagScanner({this.response});
  @override
  _TagScannerState createState() => _TagScannerState();
}

class _TagScannerState extends State<TagScanner> {
  String barcode = "";
  var account;
  final _formKey = GlobalKey<FormState>();
  bool status = false;

  static String res;

  Future scanCode() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    }
  }

  PageController _myPage = PageController(initialPage: 0);

  void initState() {
    // TODO: implement initState
    res = widget.response;
    super.initState();
    checkResponse();
  }

  checkResponse() {
    if (res == ' ') {
      setState(() {
        status = false;
      });
    } else {
      setState(() {
        status = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final routes =
    ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(
              "Register New Vehicle",
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  initialValue: barcode,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.apps),
                    hintText: "Tag number",
                    border: const OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: new Text('Cancel'),
                  color: Colors.red,
                  textColor: Colors.white,
                  splashColor: Colors.red,
                  colorBrightness: Brightness.light,
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              new FlatButton(
                  child: new Text('Register'),
                  color: Colors.teal[600],

                  textColor: Colors.white,
                  splashColor: Colors.teal[400],
                  colorBrightness: Brightness.light,
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/new-vehicle',arguments:{
                      'title':'ADD VEHICLE TO ACCOUNT',
                      'barcode': barcode,
                      'account': routes['account']
                    });
                  })
            ],
          );
        },
      );
    }

    return Scaffold(
      extendBody: true,

      body: Container(

        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image/nss.png'), fit: BoxFit.cover)),
        child: Center(

          child: ButtonTheme(
            minWidth: 200.0,
            height: 50.0,
            child: RaisedButton.icon(
              onPressed: _showDialog,

              label: Text(
                'Register New Vehicle',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              icon: Icon(Icons.local_car_wash),
              textColor: Colors.white,
              color: Colors.black,
              elevation: 15.0,
            ),
          ),

        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: scanCode,
        backgroundColor: Colors.black,
        tooltip: 'Scan',
        child: Icon(Icons.airplay),
        elevation: 2.0,
      ),
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
                  Navigator.of(context).pop();
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(3);
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

}
