import 'package:flutter/material.dart';

class CategoryButtonWidget extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback? onPressed;
  final String ImagePath;

  const CategoryButtonWidget({
    required this.title,
    this.icon,
    this.isSelected = false,
    this.onPressed,
    required this.ImagePath,
  });

  @override
  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // backgroundColor: isSelected
          //     ? Colors.teal
          //     : isDark
          //     ? Colors.grey[850]
          //     : Colors.white,
          foregroundColor: isSelected
              ? Colors.orange
              : isDark
              ? Colors.white
              : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(70),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, size: 18),
            if (icon != null) SizedBox(height: 6),
            ClipOval(
              child: Image.asset(
                ImagePath,
                height: 74,
                width: 74,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
