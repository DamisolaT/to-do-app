import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:verraki_project1/controller/folder_controller.dart';
import 'package:verraki_project1/firebase_options.dart';


import 'package:verraki_project1/views/auth/onboarding/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_)=> FolderController()..loadFolders(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: false,
      fontSizeResolver: FontSizeResolvers.height,
      child: MaterialApp(
        title: 'To-Do App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(scrolledUnderElevation: 0),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
