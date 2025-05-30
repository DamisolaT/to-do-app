import 'package:flutter/material.dart';
import 'package:verraki_project1/views/folder/widgets/archieve_page.dart';
import 'package:verraki_project1/views/folder/widgets/important_page.dart';
import 'package:verraki_project1/views/folder/widgets/notes_page.dart';
import 'package:verraki_project1/views/folder/widgets/personal_page.dart';
import 'package:verraki_project1/views/folder/widgets/projects_page.dart';
import 'package:verraki_project1/views/folder/widgets/reminder_page.dart';
import 'package:verraki_project1/views/folder/widgets/todo_page.dart';

Widget getPageForFolder(Map<String, dynamic> folder) {
  final String type = folder['fileType'];
  final String title = folder['title'];
  // final String id = folder['id'];

  switch (type) {
    case 'Notes':
      return NotesPage(folderId: 'id');
      case 'Projects':
      return ProjectsPage(folderId: 'title');
      case 'Reminders':
      return ReminderPage(folderId: 'id');
      case 'Important':
      return ImportantPage(folderId: title);
      case 'Archieve':
      return ArchievePage(folderId: 'id');
       case 'Todo':
      return TodoPage(folderId: 'id');
      
    // case 'images':
    //   return ImagesPage(folderId: id);
    default:
      return PersonalPage();
  }
}
