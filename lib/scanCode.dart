import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';


class ScanBody extends StatefulWidget {
  @override
  _ScanBodyState createState() => _ScanBodyState();
}

class _ScanBodyState extends State<ScanBody> {
  String barcode = "";
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR code'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: RaisedButton(
              color: Colors.orange,
              textColor: Colors.white,
              splashColor: Colors.blueGrey,
              onPressed: scan,
              child: Text('start camera scan'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(barcode, textAlign: TextAlign.center),
          )
        ],
      ),
    );
  }
  Future scan() async {
      try {
      ScanResult baresult = await BarcodeScanner.scan();
      setState(() {
        return this.barcode = baresult.rawContent;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          return this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() {
          return this.barcode = 'Unknown error: $e';
        });
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}

