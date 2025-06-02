import 'package:flutter/material.dart';

class PageWrapper extends StatelessWidget {
  final Widget child;
  final double padding;
  final double verticalPadding;
  final bool safeAreaPaddingTop;
  final bool safeAreaPaddingBottom;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? endDrawer;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final List<Widget>? persistentFooterButtons;
  final bool resizeToAvoidBottomInset;

  const PageWrapper({
    super.key,
    required this.child,
    this.padding = 16,
    this.verticalPadding = 16,
    this.safeAreaPaddingTop = true,
    this.safeAreaPaddingBottom = true,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.drawer,
    this.endDrawer,
    this.floatingActionButtonLocation,
    this.persistentFooterButtons,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: appBar,
        drawer: drawer,
        endDrawer: endDrawer,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        persistentFooterButtons: persistentFooterButtons,
        bottomNavigationBar: bottomNavigationBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        body: SafeArea(
          top: safeAreaPaddingTop,
          bottom: safeAreaPaddingBottom,
          child: Padding(padding: const EdgeInsets.all(16.0), child: child),
        ),
      ),
    );
  }
}
