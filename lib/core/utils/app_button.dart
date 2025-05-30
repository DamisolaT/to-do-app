import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final Color color;
  final TextStyle textStyle;
  final BorderRadiusGeometry borderRadius;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 45,
    this.color = Colors.blue,
    this.textStyle = const TextStyle(fontSize: 16, color: Colors.white),
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
