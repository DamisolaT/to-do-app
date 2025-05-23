import 'package:flutter/material.dart';

class NotesPage extends StatelessWidget {
  final String folderId;
  const NotesPage({super.key, required this.folderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: Center(child: Text('Notes for folder ID: $folderId')),
    );
  }
}
