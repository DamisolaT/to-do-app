import 'package:flutter/material.dart';

class ReminderPage extends StatelessWidget {
  final String folderId;
  const ReminderPage({super.key, required this.folderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reminder')),
      body: Center(child: Text('Reminder for folder ID: $folderId')),
    );
  }
}