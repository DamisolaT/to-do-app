import 'package:flutter/material.dart';
import 'package:verraki_project1/views/folder/widgets/notes_page.dart';
import 'package:verraki_project1/views/folder/widgets/personal_page.dart';

Widget getPageForFolder(Map<String, dynamic> folder) {
  final String type = folder['fileType'];
  // final String id = folder['id'];

  switch (type) {
    case 'Notes':
      return NotesPage(folderId: 'id');
    // case 'images':
    //   return ImagesPage(folderId: id);
    default:
      return PersonalPage();
  }
}
