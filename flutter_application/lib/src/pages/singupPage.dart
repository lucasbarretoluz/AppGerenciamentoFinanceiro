import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/src/themes/light_color.dart';

class Singup extends StatefulWidget {
  const Singup({Key? key}) : super(key: key);

  @override
  _SingupState createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: ListView(children: [
              const SizedBox(height: 16),
              Container(
                  height: 125.0,
                  width: 200.0,
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          'Registre-se',
                          style: TextStyle(
                              color: LightColor.orange,
                              fontWeight: FontWeight.w600,
                              fontSize: 50.0),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 15),
              _TextField(
                  label: 'Name',
                  controller: _nameController,
                  validator: _requiredValidator),
              const SizedBox(height: 15),
              _TextField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _requiredValidator),
              const SizedBox(height: 15),
              _TextField(
                  label: 'Senha',
                  controller: _passwordController,
                  password: true,
                  validator: _confirmPasswordValidator),
              const SizedBox(height: 15),
              _TextField(
                  label: 'Confirmar senha',
                  controller: _confirmPasswordController,
                  password: true,
                  validator: _confirmPasswordValidator),
              const SizedBox(height: 15),
              if (loading) ...[
                Center(child: CircularProgressIndicator()),
              ],
              if (!loading) ...[
                // SubmitButton(
                //   onPressed: () {
                //     if (_formkey.currentState != null &&
                //         _formkey.currentState!.validate()) {
                //       _singUp();
                //     }
                //   },
                //   padding: 16,
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState != null &&
                          _formkey.currentState!.validate()) {
                        _singUp();
                      }
                    },
                    child: Text('Criar Conta'),
                  ),
                )
              ],
              SizedBox(height: 20.0),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Voltar',
                        style: TextStyle(
                            color: LightColor.orange,
                            fontFamily: 'Trueno',
                            decoration: TextDecoration.underline)))
              ])
            ]),
          ),
        ),
      ),
    );
  }


  String? _requiredValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return 'Este campo ?? requerido.';
    }
    return null;
  }

  String? _confirmPasswordValidator(String? confirmPasswordText) {
    if (confirmPasswordText == null || confirmPasswordText.trim().isEmpty) {
      return 'Este campo ?? requerido.';
    }
    if (_passwordController.text != confirmPasswordText) {
      return 'Senha n??o corresponde.';
    }
    return null;
  }

  Future _singUp() async {

    setState(() {
      loading = true;
    });
    try {
     var result =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
       final User user = result.user!;
       final iduid = user.uid;

       print(iduid); //testar depois se esta pegando o usuario certo.

      await FirebaseFirestore.instance.collection('users').doc(iduid).set({
        'email': _emailController.text,
        'name': _nameController.text,
        'Id_usuario': iduid
      });
      
       
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Conta criada com sucesso'),
                content: Text('Sua conta foi criada, voc?? j?? pode logar!'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'))
                ],
              ));
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      _handleSingUpError(e);
      setState(() {
        loading = false;
      });
    }
  }
  

  void _handleSingUpError(FirebaseAuthException e) {
    String messageToDisplay;
    switch (e.code) {
      case 'email-already-in-use':
        messageToDisplay = 'Este email j?? est?? sendo usado.';
        break;
      case 'invalid-email':
        messageToDisplay = 'O email ?? invalido.';
        break;
      case 'operation-not-allowed':
        messageToDisplay = 'Esta opera????o n??o ?? permitida';
        break;
      case 'weak-password':
        messageToDisplay = 'A senha inserida ?? muito fraca.';
        break;
      default:
        messageToDisplay = 'Algo de errado ocorreu.';
        break;
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Criar conta falhou'),
              content: Text(messageToDisplay),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'))
              ],
            ));
  }
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool password;
  final TextInputType? keyboardType;
  final FormFieldValidator<String> validator;

  const _TextField({
    required this.label,
    required this.controller,
    required this.validator,
    this.password = false,
    this.keyboardType,
  });

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        obscureText: password,
        validator: validator,
      ),
    );
  }
}