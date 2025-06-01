import 'package:flutter/material.dart';

class BingoCell extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  final bool isFree;

  const BingoCell({
    super.key,
    required this.controller,
    required this.onTap,
    this.isFree = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isFree) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.redAccent.shade100.withOpacity(0.2),
          border: Border.all(color: Colors.redAccent.shade200),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: const Text(
          'FREE',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            border: Border.all(color: Colors.redAccent.shade200),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: Text(
            controller.text.isEmpty ? 'Tap to edit' : controller.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.redAccent.shade200,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      );
    }
  }
}
