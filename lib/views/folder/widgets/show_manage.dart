// manage_folder_dialog.dart

import 'package:flutter/material.dart';
import 'package:verraki_project1/views/folder/widgets/edit_dialogue.dart';


void showManageFolderDialog({
  required BuildContext context,
  required int index,
  required List<Map<String, dynamic>> folders,
  required TextEditingController nameController,
  required List<String> iconOptions,
  required List<String> fileTypes,
  required List<Color> colorOptions,
  required Function(List<Map<String, dynamic>>) updateFolders,
  required Function(int) onDelete, // a callback for delete
}) {
  final folderTitle = folders[index]['title'];

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Manage Folder'),
      content: Text('What do you want to do with "$folderTitle"?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            showEditFolderDialog(
              context: context,
              index: index,
              folders: folders,
              nameController: nameController,
              iconOptions: iconOptions,
              fileTypes: fileTypes,
              colorOptions: colorOptions,
              updateFolders: updateFolders,
            );
          },
          child: const Text('Edit', style: TextStyle(color: Colors.blue)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onDelete(index); 
          },
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}
