import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/src/pages/mainPage.dart';
import 'package:flutter_application/src/themes/light_color.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLoggingIn = false;

  _login() async {
    setState(() {
      isLoggingIn = true;
    });

    try {
     
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MainPage(title: '')));
    } on FirebaseAuthException catch (e) {
      var message = '';

      switch (e.code) {
        case 'invalid-email':
          message = 'O e-mail está incorreto.';
          break;
        case 'user-disable':
          message = 'O usuario está incorreto.';
          break;
        case 'user-not-found':
          message = 'O usuario não foi encontrado.';
          break;
        case 'wrong-password':
          message = 'Senha incorreta.';
          break;
      }

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Falha ao fazer login'),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'))
              ],
            );
          });
    } finally {
      setState(() {
        isLoggingIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Faça seu Login',
            style: TextStyle(
                color: LightColor.orange,
                fontSize: 25,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
          ),
          if (!isLoggingIn)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      _login();
                    },
                    child: Text('Login')),
              ),
            ),
          if (isLoggingIn) ...[
            const SizedBox(height: 16),
            Center(child: CircularProgressIndicator()),
          ]
        ],
      ),
    );
  }
}
