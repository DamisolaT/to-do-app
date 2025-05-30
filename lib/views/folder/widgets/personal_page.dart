import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:verraki_project1/core/utils/custom_app_bar.dart';
import 'package:verraki_project1/core/utils/images.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final List<PersonalContainer> _lists = [
    PersonalContainer(
      title: 'Weekly Planner',
      icon: AppIcons.pinIcon,
      number: '%20',
      containerColor: Colors.greenAccent.shade100,
      cicleColor: Colors.lightGreenAccent,
    ),
    PersonalContainer(
      title: 'Books',
      icon: AppIcons.booksIcon,
      number: '%40',
      containerColor: Colors.pink.shade50,
      cicleColor: Colors.pink.shade100,
    ),
    PersonalContainer(
      title: 'Films',
      icon: AppIcons.filmsIcon,
      number: '%60',
      containerColor: Colors.orange.shade50,
      cicleColor: Colors.orange.shade100,
    ),
    PersonalContainer(
      title: 'Games',
      icon: AppIcons.gamesIcon,
      number: '%10',
      containerColor: Colors.lightBlue.shade50,
      cicleColor: Colors.lightBlue.shade100,
    ),
  ];

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
                Divider(color: Colors.grey, thickness: 0.1),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _showNewListDialog,
                  child: Container(
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
                          const SizedBox(width: 10),
                          const Text(
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
                ),
                const SizedBox(height: 20),
                const Text(
                  'LISTS',
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Render all personal containers
                ..._lists.map(
                  (list) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: list,
                  ),
                ),

                const SizedBox(height: 20),
                const Text(
                  'TASKS',
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
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
                        children: const [
                          Text(
                            'Upcoming',
                            style: TextStyle(color: Colors.blue, fontSize: 14),
                          ),
                          Icon(Icons.arrow_drop_down, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                          children: const [
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
                            SvgPicture.asset(AppIcons.circleIcon, height: 20),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
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
                                    const SizedBox(width: 5),
                                    const Text(
                                      '09.00',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    SvgPicture.asset(
                                      AppIcons.notiIcon,
                                      height: 10,
                                    ),
                                    const SizedBox(width: 5),
                                    SvgPicture.asset(
                                      AppIcons.batteryIcon,
                                      height: 10,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
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
          ),
        ),
      ),
     
    );
  }

  void _showNewListDialog() {
    final titleController = TextEditingController();
    final progressController = TextEditingController();

    showDialog(
      context: context,
      
      builder: (context) {
      
        return AlertDialog(
          title: const Text('Add New List'),
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter list title',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: progressController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Progress (%)',
                  hintText: 'Enter progress like 40 for 40%',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text.trim();
                final progress = progressController.text.trim();

                if (title.isNotEmpty && progress.isNotEmpty) {
                  setState(() {
                    _lists.add(
                      PersonalContainer(
                        title: title,
                        icon: AppIcons.plussIcon,
                        number: '%$progress',
                        containerColor: Colors.purple.shade50,
                        cicleColor: Colors.purple.shade100,
                      ),
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Save', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
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
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
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
                            width: double.parse(number.replaceAll('%', '')),
                            decoration: BoxDecoration(
                              color: cicleColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      number,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
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
