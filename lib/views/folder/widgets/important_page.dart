
import 'package:flutter/material.dart';

class ImportantPage extends StatelessWidget {
  final String folderId;
  const ImportantPage({super.key, required this.folderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(folderId)),
      body: Center(child: Text('Importants for folder ID: $folderId')),
    );
  }
}