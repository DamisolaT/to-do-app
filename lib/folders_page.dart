import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:verraki_project1/core/utils/custom_app_bar.dart';
import 'package:verraki_project1/core/utils/images.dart';
import 'package:verraki_project1/personal_page.dart';

class FoldersPage extends StatefulWidget {
  const FoldersPage({super.key});

  @override
  State<FoldersPage> createState() => _FoldersPageState();
}

class _FoldersPageState extends State<FoldersPage> {
  // Move these variables to class level so they persist between rebuilds
  String selectedIcon = '';
  Color selectedColor = Colors.blue;
  final TextEditingController nameController = TextEditingController();

  // Default folders that will always be shown
  final Map<String, dynamic> newFolderTemplate = {
    'title': 'New Folder',
    'icon': ApppImages.plusIcon,
    'color': Colors.blue.shade100,
    'titleColor': Colors.blue,
    'number': 0,
    'subtitle': '',
    'showArrow': false,
  };

  final List<Map<String, dynamic>> defaultFolders = [
    {
      'title': 'Personal',
      'icon': ApppImages.personalImage,
      'color': Colors.grey.shade100,
      'titleColor': Colors.pink,
      'number': 4,
      'subtitle': 'List',
      'showArrow': true,
    },
    {
      'title': 'UI/UX',
      'icon': ApppImages.uiuxImage,
      'color': Colors.grey.shade100,
      'titleColor': Colors.green,
      'number': 3,
      'subtitle': 'List',
      'showArrow': true,
    },
    {
      'title': 'Writing',
      'icon': ApppImages.writingImage,
      'color': Colors.grey.shade100,
      'titleColor': Colors.green,
      'number': 3,
      'subtitle': 'List',
      'showArrow': true,
    },
    {
      'title': 'Yoga',
      'icon': ApppImages.yogaImage,
      'color': Colors.grey.shade100,
      'titleColor': Colors.green,
      'number': 3,
      'subtitle': 'List',
      'showArrow': true,
    },
    {
      'title': 'Recipes',
      'icon': ApppImages.recipesImage,
      'color': Colors.grey.shade100,
      'titleColor': Colors.green,
      'number': 3,
      'subtitle': 'List',
      'showArrow': true,
    },
  ];

  // List to hold all folders including default and user-created ones
  List<Map<String, dynamic>> folders = [];

  final List<String> iconOptions = [
    ApppImages.personalImage,
    ApppImages.uiuxImage,
    ApppImages.writingImage,
    ApppImages.yogaImage,
    ApppImages.recipesImage,
  ];

  final List<Color> colorOptions = [
    Colors.blue,
    Colors.pink,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.yellow,
  ];

  @override
  void initState() {
    super.initState();
    // Initialize with default values
    selectedIcon = iconOptions[0];
    selectedColor = colorOptions[0];

    _loadFolders();
  }

  Future<void> _loadFolders() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? savedFoldersJson = prefs.getString('user_folders');

      List<Map<String, dynamic>> loadedFolders = [newFolderTemplate];

      if (savedFoldersJson != null && savedFoldersJson.isNotEmpty) {
        final List<dynamic> decodedFolders = jsonDecode(savedFoldersJson);

        for (var folder in decodedFolders) {
          if (folder is Map<String, dynamic>) {
            folder['titleColor'] = _colorFromHex(folder['titleColor']);
            folder['color'] = _colorFromHex(folder['color']);
            loadedFolders.add(Map<String, dynamic>.from(folder));
          }
        }
      }

      setState(() {
        folders = loadedFolders;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error loading folders: $e');
      }
      setState(() {
        folders = [newFolderTemplate];
      });
    }
  }

  Future<void> _saveFolders() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final userFolders =
          folders.skip(1).map((folder) {
            final folderCopy = Map<String, dynamic>.from(folder);
            folderCopy['titleColor'] = _colorToHex(folderCopy['titleColor']);
            folderCopy['color'] = _colorToHex(folderCopy['color']);
            return folderCopy;
          }).toList();

      final String encoded = jsonEncode(userFolders);
      await prefs.setString('user_folders', encoded);
    } catch (e) {
      print('Error saving folders: $e');
    }
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }

  Color _colorFromHex(String hexString) {
    hexString = hexString.replaceFirst('#', '');
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }
    return Color(int.parse(hexString, radix: 16));
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Folders',
        showFilterIcon: true,
        showBackButton: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(color: Colors.grey, thickness: 0.5),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 15,
                  children: List.generate(folders.length, (index) {
                    final folder = folders[index];
                    final folderWidget = FoldersContainers(
                      image: folder['icon'],
                      title: folder['title'],
                      subtitle: folder['subtitle'],
                      number: folder['number'],
                      titleColor: folder['titleColor'],
                      color: folder['color'],
                      showArrow: folder['showArrow'],
                      onArrowTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PersonalPage(),
                          ),
                        );
                      },
                    );

                    if (index == 0) {
                      return GestureDetector(
                        onTap: () => showCreateFolderDialog(context),
                        child: folderWidget,
                      );
                    } else {
                      return GestureDetector(
                        onLongPress: () => _showDeleteDialog(context, index),
                        child: folderWidget,
                      );
                    }
                  }),
                ),
              ),
            ],
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

  void showCreateFolderDialog(BuildContext context) {
    // Reset or clear the text controller for a new dialog
    nameController.clear();

    // Create a StatefulBuilder to manage dialog state
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text("Create New Folder"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Folder name",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedIcon,
                    isExpanded: true,
                    onChanged: (value) {
                      if (value != null) {
                        // Use setDialogState to update the dialog's UI
                        setDialogState(() {
                          selectedIcon = value;
                        });
                        // Also update the parent widget's state so it persists
                        setState(() {
                          selectedIcon = value;
                        });
                      }
                    },
                    items:
                        iconOptions.map((iconPath) {
                          return DropdownMenuItem(
                            value: iconPath,
                            child: Image.asset(iconPath, width: 24, height: 24),
                          );
                        }).toList(),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select a color:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children:
                        colorOptions.map((color) {
                          return GestureDetector(
                            onTap: () {
                              // Update both the dialog and parent widget states
                              setDialogState(() {
                                selectedColor = color;
                              });
                              setState(() {
                                selectedColor = color;
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: color,
                              radius: 14,
                              child:
                                  selectedColor == color
                                      ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      )
                                      : null,
                            ),
                          );
                        }).toList(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final folderName = nameController.text.trim();
                    if (folderName.isNotEmpty) {
                      setState(() {
                        folders.add({
                          'title': folderName,
                          'icon': selectedIcon,
                          'color': selectedColor.withOpacity(0.2),
                          'titleColor': selectedColor,
                          'number': 0,
                          'subtitle': '',
                          'showArrow': true,
                        });
                      });

                      // Save folders to persistent storage
                      _saveFolders();

                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, int index) {
    final folderTitle = folders[index]['title'];

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Folder'),
            backgroundColor: Colors.white,
            content: Text('Are you sure you want to delete "$folderTitle"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Cancel
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    folders.removeAt(index);
                  });
                  _saveFolders(); // Persist updated list
                  Navigator.pop(context); // Close dialog
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}

class FoldersContainers extends StatelessWidget {
  const FoldersContainers({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.number,
    this.color,
    this.titleColor = Colors.blue,
    required this.showArrow,
    this.onArrowTap,
  });

  final String image;
  final String title;
  final String subtitle;
  final int number;
  final Color? color;
  final Color titleColor;
  final bool showArrow;
  final VoidCallback? onArrowTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 70),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        title,
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.clip,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    const Spacer(),
                    if (showArrow)
                      GestureDetector(
                        onTap: onArrowTap,
                        child: Icon(Icons.arrow_forward, color: titleColor),
                      ),
                  ],
                ),
                if (number != 0 && subtitle.isNotEmpty)
                  Row(
                    children: [
                      Text(
                        number.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
