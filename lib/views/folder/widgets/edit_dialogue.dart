// edit_folder_dialog.dart
import 'package:flutter/material.dart';
import 'package:verraki_project1/core/customs/custom_text.dart';


Future<void> showEditFolderDialog({
  required BuildContext context,
  required int index,
  required List<Map<String, dynamic>> folders,
  required TextEditingController nameController,
  required List<String> iconOptions,
  required List<String> fileTypes,
  required List<Color> colorOptions,
  required Function(List<Map<String, dynamic>>) updateFolders,
}) async {
  String? selectedIcon = folders[index]['icon'];
  String? selectedFileType = folders[index]['fileType'];
  Color selectedColor = folders[index]['titleColor'];

  nameController.text = folders[index]['title'];

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text("Edit Folder"),
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
                        borderSide: const BorderSide(color: Colors.blue, width: 2),
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
                        setDialogState(() => selectedIcon = value);
                      }
                    },
                    items: iconOptions.map((iconPath) {
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
                        borderSide: const BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomText(text: 'Select File Type:', fontSize: 15),
                  const SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    value: selectedFileType,
                    hint: const Text('Select File Type'),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        setDialogState(() => selectedFileType = newValue);
                      }
                    },
                    items: fileTypes.map((value) {
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
                        borderSide: const BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Select a color:", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: colorOptions.map((color) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () => setDialogState(() => selectedColor = color),
                            child: CircleAvatar(
                              backgroundColor: color,
                              radius: 14,
                              child: selectedColor == color
                                  ? const Icon(Icons.check, color: Colors.white, size: 16)
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
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel", style: TextStyle(fontSize: 18, color: Colors.grey)),
              ),
              TextButton(
                onPressed: () {
                  final folderName = nameController.text.trim();

                  if (folderName.isEmpty) return;

                  final folderExists = folders.any((folder) =>
                      folder['title'].toString().toLowerCase() == folderName.toLowerCase() &&
                      folders.indexOf(folder) != index);

                  if (folderExists) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Folder name already exists!', style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

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

                  updateFolders(folders); // Call a callback to update the folders
                  Navigator.pop(context);
                },
                child: const Text("Save", style: TextStyle(fontSize: 20, color: Colors.blue)),
              ),
            ],
          );
        },
      );
    },
  );
}
