import 'package:flutter/material.dart';


class ConfigPage extends StatefulWidget {
  @override
  State<ConfigPage> createState() {
    
    return ConfigPageState();
  }

}

class ConfigPageState extends State<ConfigPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('Configuração sera aqui', style: TextStyle(fontSize: 20)),
      ),

    );
  }
}