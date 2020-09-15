import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String barcode = "";
  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
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
                      'title':'Add new Vehicle',
                      'barcode': barcode
                    });
                  })
            ],
          );
        },
      );
    }

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Smart Toll Gate'),
        centerTitle: true,
      ),
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
                  setState(() {
                    _myPage.jumpToPage(0);
                  });
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
