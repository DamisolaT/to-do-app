// delete_dialog.dart
import 'package:flutter/material.dart';

typedef OnDeleteCallback = void Function();

void showDeleteDialog({
  required BuildContext context,
  required String folderTitle,
  required OnDeleteCallback onDelete,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete Folder'),
      backgroundColor: Colors.white,
      content: Text('Are you sure you want to delete "$folderTitle"?'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                onDelete(); // call the callback function
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Delete',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
