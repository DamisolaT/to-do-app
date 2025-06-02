
import 'package:flutter/material.dart';

class ProjectsPage extends StatelessWidget {
  final String folderId;
  const ProjectsPage({super.key, required this.folderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ProjectsPage')),
      body: Center(child: Text('Projects for folder ID: $folderId')),
    );
  }
}