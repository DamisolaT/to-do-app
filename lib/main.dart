import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verraki_project1/views/folder/folders_page.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();

  runApp(const MyApp());
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
          appBarTheme: AppBarTheme(scrolledUnderElevation: 0),
          useMaterial3: true,
        ),
        home: FoldersPage(),
      ),
    );
  }
}
