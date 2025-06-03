import 'package:flutter/material.dart';

class TextChip extends StatelessWidget {
  const TextChip({super.key, required this.label, required this.icon});

  final Widget label;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [icon, label],
    );
  }
}
