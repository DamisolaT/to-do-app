import 'package:flutter/cupertino.dart';

import 'package:verraki_project1/views/folder/folders_page.dart';
import 'package:verraki_project1/views/home/home_page.dart';
import 'package:verraki_project1/navigators/route.dart';
import 'package:verraki_project1/views/personal_page.dart';

class AppRouter {
  static final navKey = GlobalKey<NavigatorState>();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteStrings.base:
        return CupertinoPageRoute(builder: (_) => HomePage());
      case AppRouteStrings.folderPage:
        return CupertinoPageRoute(builder: (_) => FoldersPage());
      case AppRouteStrings.personalPage:
        return CupertinoPageRoute(builder: (_) => PersonalPage());
      default:
        return CupertinoPageRoute(builder: (_) => FoldersPage());
    }
  }
}
