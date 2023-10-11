import 'package:flutter/material.dart';

class NewNotesView extends StatefulWidget {
  const NewNotesView({Key? key}) : super(key: key);

  @override
  State<NewNotesView> createState() => _newNotesViewState();
}

class _newNotesViewState extends State<NewNotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('new notes'),
      ),
      body: const Text('write your new note here...'),
    );
  }
}
