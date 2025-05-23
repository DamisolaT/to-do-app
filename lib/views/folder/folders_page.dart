import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verraki_project1/core/customs/custom_text.dart';
import 'dart:convert';
import 'package:verraki_project1/core/utils/custom_app_bar.dart';
import 'package:verraki_project1/core/utils/images.dart';
import 'package:verraki_project1/models/color_list.dart';
import 'package:verraki_project1/models/folder_list.dart';
import 'package:verraki_project1/models/icon_list.dart';
import 'package:verraki_project1/views/folder/page_mapper.dart';
import 'package:verraki_project1/views/folder/widgets/folder_container.dart';

class FoldersPage extends StatefulWidget {
  const FoldersPage({super.key});

  @override
  State<FoldersPage> createState() => _FoldersPageState();
}

class _FoldersPageState extends State<FoldersPage> {
  String selectedIcon = '';
  String selectedFileType = '';
  Color selectedColor = Colors.blue;
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedIcon = iconOptions[0];
    selectedFileType = fileTypes[0];
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
              const Divider(color: Colors.grey, thickness: 0.1),
              const SizedBox(height: 5),
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
                            builder: (_) => getPageForFolder(folder),
                          ),
                        );
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => const PersonalPage(),
                        //   ),
                        // );
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
    nameController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text("Create New Folder"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  CustomText(text: 'Select Icon:', fontSize: 15),
                  DropdownButtonFormField<String>(
                    value: selectedIcon,
                    isExpanded: true,
                    onChanged: (value) {
                      if (value != null) {
                        setDialogState(() {
                          selectedIcon = value;
                        });
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
                  const SizedBox(height: 10),
                  CustomText(text: 'Select File Type:', fontSize: 15),
                  const SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    value: selectedFileType,
                    hint: const Text('Select File Type'),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFileType = newValue!;
                      });
                    },
                    items:
                        fileTypes.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
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
                  SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select a color:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          colorOptions.map((color) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                onTap: () {
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
                              ),
                            );
                          }).toList(),
                    ),
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
                          'fileType': selectedFileType,
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
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    folders.removeAt(index);
                  });
                  _saveFolders();
                  Navigator.pop(context);
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
