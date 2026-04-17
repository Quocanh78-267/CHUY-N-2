import 'package:flutter/material.dart';

class FoodEmojiArt extends StatelessWidget {
  final String emoji;
  final double size;

  const FoodEmojiArt({
    super.key,
    required this.emoji,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.15),
      ),
      alignment: Alignment.center,
      child: Text(
        emoji,
        style: TextStyle(
          fontSize: size * 0.62,
        ),
      ),
    );
  }
}