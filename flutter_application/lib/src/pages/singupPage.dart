import 'package:flutter/material.dart';
import 'package:flutter_application/src/widgets/extentions.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: ListView(children: [
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formkey.currentState != null &&
                    _formkey.currentState!.validate()) {}
              },
              child: Text('Criar Conta'),
            ),
          )
        ]),
      ),
    );
  }

  String? _requiredValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return 'Este campo é requerido.';
    }
    return null;
  }

  String? _confirmPasswordValidator(String? confirmPasswordText) {
    if (confirmPasswordText == null || confirmPasswordText.trim().isEmpty) {
      return 'Este campo é requerido.';
    }
    if (_passwordController.text != confirmPasswordText) {
      return 'Senha não corresponde.';
    }
    return null;
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
