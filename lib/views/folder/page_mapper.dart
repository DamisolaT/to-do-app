import 'package:flutter/material.dart';
import 'package:verraki_project1/views/folder/folder_pages/archieve_page.dart';
import 'package:verraki_project1/views/folder/folder_pages/important_page.dart';
import 'package:verraki_project1/views/folder/folder_pages/notes_page.dart';
import 'package:verraki_project1/views/folder/folder_pages/personal_page.dart';
import 'package:verraki_project1/views/folder/folder_pages/projects_page.dart';
import 'package:verraki_project1/views/folder/folder_pages/reminder_page.dart';
import 'package:verraki_project1/views/folder/folder_pages/todo_page.dart';



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
