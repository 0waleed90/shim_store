import 'package:flutter/material.dart';
import 'package:my_store/core/util/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.icon,
    required this.color,
    required this.textColor,
    required this.width,
    this.borderColor,
    required this.onTap,
  });
  final String text;
  final IconData? icon;
  final Color color;
  final Color textColor;
  final double width;
  final Color? borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.transparent),
          borderRadius: .circular(8),
          color: color,
        ),

        child: Row(
          mainAxisAlignment: .center,
          children: [
            Text(
              text,
              style: Styles.textStyle16.copyWith(
                color: textColor,
                fontWeight: .w500,
              ),
            ),
            const SizedBox(width: 10),
            Icon(color: textColor, icon),
          ],
        ),
      ),
    );
  }
}
