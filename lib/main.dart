import 'package:flutter/material.dart';
import 'package:verraki_project1/views/folder/folders_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(scrolledUnderElevation: 0),
        useMaterial3: true,
      ),
      home: FoldersPage(),
    );
  }
}
