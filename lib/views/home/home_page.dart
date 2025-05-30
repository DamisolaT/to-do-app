import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:verraki_project1/views/folder/widgets/add_page.dart';
import 'package:verraki_project1/core/utils/images.dart';
import 'package:verraki_project1/views/folder/folders_page.dart';
import 'package:verraki_project1/views/folder/widgets/personal_page.dart';
import 'package:verraki_project1/views/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentindex = 0;
  final screens = [FoldersPage(), PersonalPage(), SettingsPage(), AddPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: currentindex,
        type: BottomNavigationBarType.fixed,

        iconSize: 30,

        onTap: (value) {
          currentindex = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcons.homeIcon, height: 20),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcons.folderIcon, height: 20),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcons.personalIcon, height: 20),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcons.addIcon, height: 20),
            label: "",
          ),
        ],
      ),
      body: screens[currentindex],
    );
  }
}
