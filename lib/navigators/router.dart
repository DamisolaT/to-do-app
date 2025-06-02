import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:verraki_project1/views/folder/folders_page.dart';
import 'package:verraki_project1/views/home/home_page.dart';
import 'package:verraki_project1/navigators/route.dart';
import 'package:verraki_project1/views/folder/widgets/personal_page.dart';

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

void navigateToPage(BuildContext context, Widget page) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    ),
  );
}

void navigateToNextPageWithoutHistory(BuildContext context, String page) {
  Navigator.pushReplacementNamed(context, page);
}

void navigateToPageOutOfNavBar(BuildContext context, Widget page) {
  Navigator.of(
    context,
    rootNavigator: true,
  ).push(MaterialPageRoute(builder: (context) => page));
}
