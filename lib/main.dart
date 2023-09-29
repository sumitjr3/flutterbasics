import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterbasics/views/login_view.dart';
import 'package:flutterbasics/views/register_view.dart';
import 'package:flutterbasics/views/verify_email_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    title: 'demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      '/login/': (context) => const LoginView(),
      '/register/': (context) => const RegisterView(),
      '/notesView/': (context) => const NotesView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (Firebase.apps.isNotEmpty) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (user.emailVerified) {
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

enum MenuAction { logout }

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) {},
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('log out'),
                ),
              ];
            },
          )
        ],
      ),
      body: const Text('hello world'),
    );
  }
}
