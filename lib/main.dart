import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterbasics/constants/routes.dart';
import 'package:flutterbasics/services/auth/auth_service.dart';
import 'package:flutterbasics/views/login_view.dart';
import 'package:flutterbasics/views/notes_view.dart';
import 'package:flutterbasics/views/register_view.dart';
import 'package:flutterbasics/views/verify_email_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.firebase().initialize();
  runApp(MaterialApp(
    title: 'demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      notesRoute: (context) => const NotesView(),
      verifyEmailRoute: (context) => const VerifyEmail(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (Firebase.apps.isNotEmpty) {
      final user = AuthService.firebase().currentUser;
      if (user != null) {
        if (user.isEmailVerified) {
          return const NotesView();
        } else {
          return const VerifyEmail();
        }
      } else {
        return const LoginView();
      }
    } else {
      return const CircularProgressIndicator(); // Show a loading indicator while Firebase initializes.
    }
  }
}
