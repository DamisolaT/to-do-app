// Default folders that will always be shown
import 'package:flutter/material.dart';
import 'package:verraki_project1/core/utils/images.dart';

final Map<String, dynamic> newFolderTemplate = {
  'title': 'New Folder',
  'icon': ApppImages.plusIcon,
  'color': Colors.blue.shade100,
  'titleColor': Colors.blue,
  'number': 0,
  'subtitle': '',
  'showArrow': false,
  'fileType': 'Personal',
};

final List<Map<String, dynamic>> defaultFolders = [
  {
    'title': 'Personal',
    'icon': ApppImages.personalImage,
    'color': Colors.grey.shade100,
    'titleColor': Colors.pink,
    'number': 4,
    'subtitle': 'List',
    'showArrow': true,
    'fileType': 'Personal',
  },
  {
    'title': 'UI/UX',
    'icon': ApppImages.uiuxImage,
    'color': Colors.grey.shade100,
    'titleColor': Colors.green,
    'number': 3,
    'subtitle': 'List',
    'showArrow': true,
    'fileType': 'Personal',
  },
  {
    'title': 'Writing',
    'icon': ApppImages.writingImage,
    'color': Colors.grey.shade100,
    'titleColor': Colors.green,
    'number': 3,
    'subtitle': 'List',
    'fileType': 'Personal',
    'showArrow': true,
  },
  {
    'title': 'Yoga',
    'icon': ApppImages.yogaImage,
    'color': Colors.grey.shade100,
    'titleColor': Colors.green,
    'number': 3,
    'subtitle': 'List',
    'showArrow': true,
    'fileType': 'Personal',
  },
  {
    'title': 'Recipes',
    'icon': ApppImages.recipesImage,
    'color': Colors.grey.shade100,
    'titleColor': Colors.green,
    'number': 3,
    'subtitle': 'List',
    'showArrow': true,
    'fileType': 'Personal',
  },
];

// List to hold all folders including default and user-created ones
List<Map<String, dynamic>> folders = [];

final List<String> fileTypes = ['Personal', 'Notes', 'Todo'];
