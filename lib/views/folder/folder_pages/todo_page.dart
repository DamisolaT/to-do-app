import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  final String folderId;
  const TodoPage({super.key, required this.folderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo')),
      body: Center(child: Text('Todo for folder ID: $folderId')),
    );
  }
}