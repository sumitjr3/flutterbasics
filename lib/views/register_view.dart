// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutterbasics/constants/routes.dart';
import 'package:flutterbasics/services/auth/auth_exception.dart';
import 'package:flutterbasics/services/auth/auth_service.dart';
import 'package:flutterbasics/utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email, _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'enter email'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'enter password'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              try {
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on WeakPasswordAuthException {
                showErrorDialog(
                  context,
                  'weak password',
                );
              } on EmailAlreadyInUseAuthException {
                showErrorDialog(
                  context,
                  'email already in use',
                );
              } on InvalidEmailAuthException {
                showErrorDialog(
                  context,
                  'invalid email',
                );
              } on GenericAuthException {
                showErrorDialog(
                  context,
                  'failed to register',
                );
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (route) => false,
                );
              },
              child: const Text('Already registered? login here.')),
        ],
      ),
    );
  }
}
