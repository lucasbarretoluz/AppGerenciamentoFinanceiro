import 'package:flutter/material.dart';
import 'package:flutter_application/src/themes/light_color.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:async';

class QRCodePage extends StatefulWidget {
  QRCodePage({Key? key}) : super(key: key);

  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  late double height, width;

  String ticket = '';
  List<String> tickets = [];

  get children => null;

  get child => null;

  readQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      "#FFFFFF",
      "Cancelar",
      false,
      ScanMode.QR,
    );
    setState(() => ticket = code != '-1' ? code : 'Não validado');

    Stream<dynamic>? reader = FlutterBarcodeScanner.getBarcodeStreamReceiver(
      "#FFFFFF",
      "Cancelar",
      false,
      ScanMode.QR,
    );
    if (reader != null)
      reader.listen((code) {
        setState(() {
          if (!tickets.contains(code.toString()) && code != '-1')
            tickets.add(code.toString());
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Cadastre a NF-e',
                  style: TextStyle(
                      color: LightColor.orange,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 16),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Container(
                      height: height * .5,
                      width: width * .9,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 110,
                      child: ElevatedButton.icon(
                        onPressed: readQRCode,
                        icon: Icon(Icons.qr_code),
                        label: Text('Scanear QR'),
                      ),
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      child: Image.asset('assets/images/qrcode.png'),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                    height: height * .3,
                    width: width * .9,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Text(
                          'Adicionar NF-e usando URL da nota:',
                          style: TextStyle(
                              color: LightColor.orange,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Link escrito na nota fiscal',
                                border: OutlineInputBorder()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {}, child: Text('Enviar NF-e')),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
