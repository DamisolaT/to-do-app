import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:verraki_project1/core/utils/custom_app_bar.dart';

import 'package:verraki_project1/models/color_list.dart';
import 'package:verraki_project1/models/folder_list.dart';
import 'package:verraki_project1/models/icon_list.dart';
import 'package:verraki_project1/controller/folder_controller.dart';
import 'package:verraki_project1/views/folder/widgets/create_folder_dialogue.dart';
import 'package:verraki_project1/views/folder/widgets/delete_dialogue.dart';

import 'package:verraki_project1/views/folder/widgets/page_mapper.dart';
import 'package:verraki_project1/views/folder/folder_pages/folder_container.dart';
import 'package:verraki_project1/views/folder/widgets/show_manage.dart';

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
    folders = folderController.folders;

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
                              context: context,
                              nameController: nameController,
                              iconOptions: iconOptions,
                              fileTypes: fileTypes,
                              colorOptions: colorOptions,
                              selectedIcon: selectedIcon,
                              selectedFileType: selectedFileType,
                              selectedColor: selectedColor,
                              onIconChanged: (val) {
                                setState(() => selectedIcon = val!);
                              },
                              onFileTypeChanged: (val) {
                                setState(() => selectedFileType = val!);
                              },
                              onColorSelected: (val) {
                                setState(() => selectedColor = val);
                              },
                            ),
                        child: folderWidget,
                      );
                    } else {
                      return GestureDetector(
                        onLongPress:
                            () => showManageFolderDialog(
                              context: context,
                              index: index,
                              folders: folders,
                              nameController: nameController,
                              iconOptions: iconOptions,
                              fileTypes: fileTypes,
                              colorOptions: colorOptions,
                              updateFolders: (updatedList) {
                                setState(() {
                                  folders = updatedList;
                                });
                              },
                              onDelete: (index) {
                                final folderTitle = folders[index]['title'];

                                showDeleteDialog(
                                  context: context,
                                  folderTitle: folderTitle,
                                  onDelete: () {
                                    setState(() {
                                      folders.removeAt(index);
                                    });

                                    Provider.of<FolderController>(
                                      context,
                                      listen: false,
                                    ).saveFolders();
                                  },
                                );
                              },
                            ),
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
}
