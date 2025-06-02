// ignore_for_file: file_names
import 'package:flutter/material.dart';

class FoldersContainers extends StatelessWidget {
  const FoldersContainers({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.number,
    this.color,
    this.titleColor = Colors.blue,
    required this.showArrow,
    this.onArrowTap,
  });

  final String image;
  final String title;
  final String subtitle;
  final int number;
  final Color? color;
  final Color titleColor;
  final bool showArrow;
  final VoidCallback? onArrowTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 70),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        title,
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.clip,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    const Spacer(),
                    if (showArrow)
                      GestureDetector(
                        onTap: onArrowTap,
                        child: Icon(Icons.arrow_forward, color: titleColor),
                      ),
                  ],
                ),
                if (number != 0 && subtitle.isNotEmpty)
                  Row(
                    children: [
                      Text(
                        number.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
