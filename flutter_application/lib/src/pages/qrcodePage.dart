import 'package:flutter/material.dart';
import 'package:flutter_application/src/model/taketInfoQr.dart';
import 'package:flutter_application/src/themes/light_color.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:async';
import 'package:flutter_application/src/model/getInfos.dart';

class QRCodePage extends StatefulWidget {
  QRCodePage({Key? key}) : super(key: key);

  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  late double heightScreen, widthScreen;

  String savaTestStringQr = " ";
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
    heightScreen = MediaQuery.of(context).size.height;
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: heightScreen * .16), //testar para deixar responsivo
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
                      height: heightScreen * .45,
                      width: widthScreen * .9,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
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
                SizedBox(height: heightScreen * .10), //testar para deixar responsivo
                Container(
                    height: heightScreen * .3,
                    width: widthScreen * .9,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
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
                            onChanged: (text){
                              ticket = text;
                            },
                            decoration: InputDecoration(
                                hintText: 'Link escrito na nota fiscal',
                                border: OutlineInputBorder()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {
                               savaTestStringQr = capturaItens(ticket) as String;
                               print(savaTestStringQr); //testar se esta pegando o qr code.
                                print(ticket);
                              }, child: Text('Enviar NF-e')),
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
