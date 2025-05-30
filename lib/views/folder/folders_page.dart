import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:verraki_project1/core/customs/custom_text.dart';

import 'package:verraki_project1/core/utils/custom_app_bar.dart';

import 'package:verraki_project1/models/color_list.dart';
import 'package:verraki_project1/models/folder_list.dart';
import 'package:verraki_project1/models/icon_list.dart';
import 'package:verraki_project1/controller/folder_controller.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FolderController>(context, listen: false).loadFolders();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final folderController = Provider.of<FolderController>(context);
    final folders = folderController.folders;
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
                        onTap:
                            () => showCreateFolderDialog(
                              context,
                              folderController,
                            ),
                        child: folderWidget,
                      );
                    } else {
                      return GestureDetector(
                        onLongPress:
                            () => _showManageFolderDialog(context, index),
                        //onTap: () => showEditFolderDialog(context, index),
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
      //
    );
  }

  ///Implement edit folder.
  void showEditFolderDialog(BuildContext context, int index) {
    final folder = folders[index];

    nameController.text = folder['title'];
    selectedIcon = folder['icon'];
    selectedFileType = folder['fileType'];
    selectedColor = folder['titleColor'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text("Edit Folder"),
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
                      setDialogState(() {
                        selectedFileType = newValue!;
                      });
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

                    if (folderName.isEmpty) return;

                    final folderExists = folders.any(
                      (folder) =>
                          folder['title'].toString().toLowerCase() ==
                              folderName.toLowerCase() &&
                          folders.indexOf(folder) != index,
                    );

                    if (folderExists) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Folder name already exists!',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    setState(() {
                      folders[index] = {
                        'title': folderName,
                        'icon': selectedIcon,
                        'color': selectedColor.withOpacity(0.2),
                        'titleColor': selectedColor,
                        'number': folders[index]['number'],
                        'subtitle': folders[index]['subtitle'],
                        'showArrow': folders[index]['showArrow'],
                        'fileType': selectedFileType,
                      };
                    });

                    FolderController();
                    Navigator.pop(context);
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

  void _showManageFolderDialog(BuildContext context, int index) {
    final folderTitle = folders[index]['title'];

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Manage Folder'),
            content: Text('What do you want to do with "$folderTitle"?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  showEditFolderDialog(context, index);
                },
                child: const Text('Edit', style: TextStyle(color: Colors.blue)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showDeleteDialog(context, index);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
    );
  }

  void showCreateFolderDialog(
    BuildContext context,
    FolderController folderController,
  ) {
    nameController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text("Create New Folder"),
              content: SingleChildScrollView(
                child: Column(
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
                              child: Image.asset(
                                iconPath,
                                width: 24,
                                height: 24,
                              ),
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
                          fileTypes.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
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
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    final folderName = nameController.text.trim();

                    if (folderName.isEmpty) return;

                    final folderController = Provider.of<FolderController>(
                      context,
                      listen: false,
                    );

                    final folderExists = folderController.folders.any(
                      (folder) =>
                          folder['title'].toString().toLowerCase() ==
                          folderName.toLowerCase(),
                    );

                    if (folderExists) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Folder name already exists!',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    folderController.addFolder({
                      'title': folderName,
                      'icon': selectedIcon,
                      'color': selectedColor.withOpacity(0.2),
                      'titleColor': selectedColor,
                      'number': 0,
                      'subtitle': '',
                      'showArrow': true,
                      'fileType': selectedFileType,
                    });

                    Navigator.pop(context);
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
                  Provider.of<FolderController>(
                    context,
                    listen: false,
                  ).saveFolders();
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
    // ignore: unused_element
  }
}
