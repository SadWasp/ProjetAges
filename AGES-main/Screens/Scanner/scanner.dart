import 'package:ages_app/Module/utils.dart' as utils;
import 'package:ages_app/Users/User.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ages_app/Module/MyProvider.dart';
import '../../../Module/custom_appbar.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScanPage extends StatefulWidget {
  @override
  _BarcodeScanPageState createState() => _BarcodeScanPageState();
}

class _BarcodeScanPageState extends State<BarcodeScanPage> {
  String? scanResult;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment(1, 1),
            end: Alignment(-1, -1),
            colors: [
              Colors.blue.shade400,
              Colors.red.shade200,
            ],
          )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 50, horizontal: 25.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 5)),
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          onPrimary: Colors.black,
                        ),
                        icon: Icon(Icons.camera_alt_outlined),
                        label: Text('Scan'),
                        onPressed: scanBarcode,
                      ),
                      SizedBox(height: 20),
                      Text(
                        scanResult ??= "Cliquer sur le bouton pour scanner",
                        style: TextStyle(fontSize: 18),
                      ),
                      ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Annuler"))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Future scanBarcode() async {
    String scanResult;

    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.BARCODE,
      );
    } on Exception {
      scanResult = 'ERROR';
    }
    context.read<MyProvider>().setScan(scanResult);
    setState(() => this.scanResult = scanResult);
    Navigator.pop(context);
  }
}
