import 'package:flutter/material.dart';

class smallButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color backgroundColor;
  final Color fontColor;

  const smallButton({super.key, required this.onTap,
    required this.label,
    required this.backgroundColor,
    required this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor:backgroundColor,
      labelPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      label: Text(label,
      style: TextStyle(
        color: fontColor,
        fontSize: 16,
      ),
      ),);
  }
}
