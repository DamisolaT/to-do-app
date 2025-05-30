import 'package:flutter/material.dart';

class TravelPage extends StatelessWidget {
  final String folderId;
  const TravelPage({super.key, required this.folderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Travel')),
      body: Center(child: Text('Travel for folder ID: $folderId')),
    );
  }
}