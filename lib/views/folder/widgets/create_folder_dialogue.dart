import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verraki_project1/controller/folder_controller.dart';
import 'package:verraki_project1/core/customs/custom_text.dart';

void showCreateFolderDialog({
  required BuildContext context,
  required TextEditingController nameController,
  required List<String> iconOptions,
  required List<Color> colorOptions,
  required List<String> fileTypes,
  required String? selectedIcon,
  required String? selectedFileType,
  required Color selectedColor,
  required Function(String?) onIconChanged,
  required Function(String?) onFileTypeChanged,
  required Function(Color) onColorSelected,
}) {
  nameController.clear();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      Color _currentSelectedColor = selectedColor; // local selected color state

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
                  const CustomText(text: 'Select Icon:', fontSize: 15),
                  DropdownButtonFormField<String>(
                    value: selectedIcon,
                    isExpanded: true,
                    onChanged: (value) {
                      if (value != null) {
                        setDialogState(() => onIconChanged(value));
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
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const CustomText(text: 'Select File Type:', fontSize: 15),
                  const SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    value: selectedFileType,
                    hint: const Text('Select File Type'),
                    onChanged: (newValue) {
                      setDialogState(() => onFileTypeChanged(newValue));
                    },
                    items: fileTypes.map((String value) {
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
                  const SizedBox(height: 10),
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
                      children: colorOptions.map((color) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              setDialogState(() {
                                _currentSelectedColor = color;
                              });
                              onColorSelected(color);
                            },
                            child: CircleAvatar(
                              backgroundColor: color,
                              radius: 14,
                              child: _currentSelectedColor == color
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
            actionsAlignment: MainAxisAlignment.spaceBetween, // spread buttons
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(fontSize: 20),
                ),
              ),
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
                    'color': _currentSelectedColor.withOpacity(0.2),
                    'titleColor': _currentSelectedColor,
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
