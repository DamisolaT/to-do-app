// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:verraki_project1/core/utils/custom_app_bar.dart';
import 'package:verraki_project1/core/utils/images.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Personal', showFilterIcon: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: Colors.grey, thickness: 0.1),
                    SizedBox(height: 20),
                    Container(
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.plussIcon,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'New List',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'LISTS',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    PersonalContainer(
                      title: 'Weekly Planner',
                      icon: AppIcons.pinIcon,
                      number: '%20',
                      containerColor: Colors.greenAccent.shade100,
                      cicleColor: Colors.lightGreenAccent,
                    ),
                    SizedBox(height: 20),
                    PersonalContainer(
                      title: 'Books',
                      icon: AppIcons.booksIcon,
                      number: '%40',
                      containerColor: Colors.pink.shade50,
                      cicleColor: Colors.pink.shade100,
                    ),
                    SizedBox(height: 20),
                    PersonalContainer(
                      title: 'Films',
                      icon: AppIcons.filmsIcon,
                      number: '%60',
                      containerColor: Colors.orange.shade50,
                      cicleColor: Colors.orange.shade100,
                    ),
                    SizedBox(height: 20),
                    PersonalContainer(
                      title: 'Games',
                      icon: AppIcons.gamesIcon,
                      number: '%10',
                      containerColor: Colors.lightBlue.shade50,
                      cicleColor: Colors.lightBlue.shade100,
                    ),

                    SizedBox(height: 20),
                    Text(
                      'TASKS',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 30,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.shade50,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Row(
                            children: [
                              Text(
                                'Upcoming',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down, color: Colors.blue),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Weekly Planner',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.expand_more,
                                  color: Colors.green,
                                  size: 40,
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                SvgPicture.asset(
                                  AppIcons.circleIcon,
                                  height: 20,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Update planner',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppIcons.alarmIcon,
                                          height: 10,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          '09.00',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        SvgPicture.asset(
                                          AppIcons.notiIcon,
                                          height: 10,
                                        ),
                                        SizedBox(width: 5),
                                        SvgPicture.asset(
                                          AppIcons.batteryIcon,
                                          height: 10,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'High',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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

class PersonalContainer extends StatelessWidget {
  const PersonalContainer({
    super.key,
    required this.title,
    required this.icon,
    required this.number,
    required this.containerColor,
    required this.cicleColor,
  });

  final String title;
  final String icon;
  final Color containerColor;
  final String number;
  final Color cicleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cicleColor,
              ),
              child: Center(child: SvgPicture.asset(icon, color: Colors.black)),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Row(
                  children: [
                    Container(
                      width: 200,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            decoration: BoxDecoration(
                              color: cicleColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      number,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
            const Icon(Icons.chevron_right, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
