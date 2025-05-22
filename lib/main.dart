import 'package:flutter/material.dart';
import 'package:verraki_project1/folders_page.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       appBarTheme: AppBarTheme(scrolledUnderElevation: 0),
        useMaterial3: true,
      ),
    //  navigatorKey: AppRouter.navKey,
    //   onGenerateRoute: AppRouter.onGenerateRoute,
    //   initialRoute: AppRouteStrings.base,
    home: FoldersPage(),
    );
  }
}


