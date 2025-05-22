import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:verraki_project1/core/utils/custom_app_bar.dart';
import 'package:verraki_project1/core/utils/images.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Settings', showFilterIcon: false),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: Colors.grey, thickness: 0.5,),
                SizedBox(height: 20),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: Center(
                          child: ClipOval(
                            child: SvgPicture.asset(
                              AppIcons.girlIcon,
                              height: 70,
                              width: 70,
                              //fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.lightBlue.shade50,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: SvgPicture.asset(
                              AppIcons.editIcon,
                              height: 16,
                              width: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'PROFILE',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                SettingsContainer(
                  title: 'Username',
                  settingIcon: AppIcons.profileIcon,
                  subtitle: 'Damisola',
                  arrowIcon: Icons.arrow_forward_ios,
                  showSubstitle: true,
                  showArrow: true,
                  isSwitched: false,
                  showSettingIcon: true,
                  titleColor: Colors.black,
                ),
                SizedBox(height: 10),
                SettingsContainer(
                  title: 'Email',
                  settingIcon: AppIcons.emailIcon,
                  subtitle: 'Damisola@gmail.com',
                  arrowIcon: Icons.arrow_forward_ios,
                  showSubstitle: true,
                  showArrow: true,
                  isSwitched: false,
                  showSettingIcon: true,
                  titleColor: Colors.black,
                ),
                SizedBox(height: 10),
                SettingsContainer(
                  title: 'Password',
                  settingIcon: AppIcons.passwordIcon,
                  subtitle: '******',
                  arrowIcon: Icons.arrow_forward_ios,
                  showSubstitle: true,
                  showArrow: true,
                  isSwitched: false,
                  showSettingIcon: true,
                  titleColor: Colors.black,
                ),
                SizedBox(height: 10),
                SettingsContainer(
                  title: 'Dark Mode',
                  settingIcon: AppIcons.modeIcon,
                  subtitle: 'Damisola',
                  arrowIcon: Icons.arrow_forward_ios,
                  showSubstitle: false,
                  showArrow: false,
                  isSwitched: true,
                  showSettingIcon: true,
                  titleColor: Colors.black,
                ),
                SizedBox(height: 20),
                Text(
                  'ACCOUNT',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                SettingsContainer(
                  title: 'Language',
                  settingIcon: AppIcons.languageIcon,
                  subtitle: 'English(UK)',
                  arrowIcon: Icons.arrow_forward_ios,
                  showSubstitle: true,
                  showArrow: true,
                  isSwitched: false,
                  showSettingIcon: true,
                  titleColor: Colors.black,
                ),
                SizedBox(height: 10),
                SettingsContainer(
                  title: 'Birthday',
                  settingIcon: AppIcons.birthdayIcon,
                  subtitle: 'June 30, 1900',
                  arrowIcon: Icons.arrow_forward_ios,
                  showSubstitle: true,
                  showArrow: true,
                  isSwitched: false,
                  showSettingIcon: true,
                  titleColor: Colors.black,
                ),
                SizedBox(height: 10),
                SettingsContainer(
                  title: 'Log Out',
                  settingIcon: AppIcons.modeIcon,
                  subtitle: '',
                  arrowIcon: Icons.arrow_forward_ios,
                  showSubstitle: false,
                  showArrow: false,
                  isSwitched: false,
                  showSettingIcon: false,
                  isLogout: true,
                  titleColor: Colors.blue,
                ),
                SizedBox(height: 10),
                SettingsContainer(
                  title: 'Delete My Account',
                  settingIcon: AppIcons.modeIcon,
                  subtitle: '',
                  arrowIcon: Icons.arrow_forward_ios,
                  showSubstitle: false,
                  showArrow: false,
                  isSwitched: false,
                  showSettingIcon: false,
                  isLogout: false,
                  titleColor: Colors.red,
                  showDeleteIcon: true,
                  deleteIcon: AppIcons.deleteIcon,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: SvgPicture.asset(AppIcons.homeIcon, width: 24, height: 24),
            ),
            label: '',
          ),

          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: SvgPicture.asset(
                AppIcons.folderIcon,
                width: 24,
                height: 24,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: SvgPicture.asset(
                AppIcons.personalIcon,
                width: 24,
                height: 24,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: SvgPicture.asset(AppIcons.addIcon, width: 24, height: 24),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({
    super.key,
    required this.title,
    required this.settingIcon,
    required this.subtitle,
    required this.arrowIcon,
    this.showSubstitle = false,
    this.showArrow = false,
    required this.isSwitched,
    required this.showSettingIcon,
    this.isLogout = false,
    required this.titleColor,
    this.showDeleteIcon = false,
    this.deleteIcon = '',
  });

  final String title;
  final String settingIcon;
  final String subtitle;
  final IconData arrowIcon;
  final bool showSubstitle;
  final bool showArrow;
  final bool isSwitched;
  final bool showSettingIcon;
  final bool isLogout;
  final Color titleColor;
  final bool showDeleteIcon;
  final String deleteIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (showSettingIcon)
                  SvgPicture.asset(
                    settingIcon,
                    height: 25,
                    width: 25,
                    color: Colors.blue,
                  ),
                if (showSettingIcon) const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                if (showSubstitle)
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                if (showSubstitle) const SizedBox(width: 10),

                if (isLogout)
                  SvgPicture.asset(
                    AppIcons.logoutIcon,
                    height: 20,
                    color: Colors.blue,
                  )
                else if (showDeleteIcon)
                  SvgPicture.asset(deleteIcon, height: 30, color: Colors.red)
                else if (showArrow)
                  Icon(arrowIcon, size: 20, color: Colors.blue)
                else
                  Switch(
                    value: isSwitched,
                    onChanged: null,
                    activeColor: Colors.blue,
                    inactiveTrackColor: Colors.grey.shade300,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
