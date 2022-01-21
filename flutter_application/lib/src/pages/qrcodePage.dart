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
          Column(
            children: [
              SizedBox(height: 16),
              Center(
                child: Container(
                  // padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  height: height * .4,
                  width: width * .9,
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Container(
                  height: height * .4,
                  width: width * .9,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      // body: Container(
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       if (ticket != '')
      //         Padding(
      //           padding: EdgeInsets.only(bottom: 24.0),
      //           child: Text(
      //             'Ticket: $ticket',
      //             style: TextStyle(fontSize: 20),
      //           ),
      //         ),
      //       ElevatedButton.icon(
      //         onPressed: readQRCode,
      //         icon: Icon(Icons.qr_code),
      //         label: Text('Validar'),
      //       ),
      //       const SizedBox(height: 50),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: TextField(
      //           decoration: InputDecoration(
      //               hintText: 'Url da nota fiscal',
      //               border: OutlineInputBorder()),
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child:
      //             ElevatedButton(onPressed: () {}, child: Text('Enviar nota')),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
