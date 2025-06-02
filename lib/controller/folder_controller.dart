import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verraki_project1/models/folder_list.dart';

class FolderController extends ChangeNotifier {
  // Make sure folders is declared here to hold the folder data
  List<Map<String, dynamic>> folders = [newFolderTemplate];

  void setFolders(List<Map<String, dynamic>> updatedList) {
  folders = updatedList;
  saveFolders();
  notifyListeners();
}

   void addFolder(Map<String, dynamic> folder) {
    folders.add(folder);
    saveFolders();
    notifyListeners();
  }

  void updateFolder(int index, Map<String, dynamic> newFolder) {
    folders[index] = newFolder;
    notifyListeners();
  }
  Future<void> saveFolders() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final userFolders = folders.skip(1).map((folder) {
        final folderCopy = Map<String, dynamic>.from(folder);
        folderCopy['titleColor'] = colorToHex(folderCopy['titleColor']);
        folderCopy['color'] = colorToHex(folderCopy['color']);
        return folderCopy;
      }).toList();

      final String encoded = jsonEncode(userFolders);
      await prefs.setString('user_folders', encoded);
    } catch (e) {
      // Optionally log or handle error
      if (kDebugMode) print('Error saving folders: $e');
    }
  }

  Future<void> loadFolders() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? savedFoldersJson = prefs.getString('user_folders');

      List<Map<String, dynamic>> loadedFolders = [newFolderTemplate];

      if (savedFoldersJson != null && savedFoldersJson.isNotEmpty) {
        final List<dynamic> decodedFolders = jsonDecode(savedFoldersJson);

        for (var folder in decodedFolders) {
          if (folder is Map<String, dynamic>) {
            folder['titleColor'] = colorFromHex(folder['titleColor']);
            folder['color'] = colorFromHex(folder['color']);
            loadedFolders.add(Map<String, dynamic>.from(folder));
          }
        }
      }

      folders = loadedFolders;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading folders: $e');
      }
      folders = [newFolderTemplate];
      notifyListeners();
    }
  }

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }

  Color colorFromHex(String hexString) {
    hexString = hexString.replaceFirst('#', '');
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }
    return Color(int.parse(hexString, radix: 16));
  }
}