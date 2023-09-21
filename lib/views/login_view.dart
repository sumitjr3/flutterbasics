import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _login_viewState();
}

class _login_viewState extends State<LoginView> {
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
    return Column(
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
              final userCredential = FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email, password: password);
            } on FirebaseAuthException catch (e) {
              print(e.code);
            }
          },
          child: const Text('login'),
        ),
      ],
    );
  }
}
