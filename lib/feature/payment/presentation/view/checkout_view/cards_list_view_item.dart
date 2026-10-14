import 'package:flutter/material.dart';

import '../../../../../core/util/styles.dart';

class CardsListViewItem extends StatelessWidget {
  const CardsListViewItem({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.payMethodName,
    required this.payMethodIcon,
  });
  final VoidCallback onTap;
  final bool isSelected;
  final String payMethodName;
  final Icon payMethodIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: .circular(10),
          ),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Row(
              mainAxisAlignment: .center,
              children: [
                Icon(
                  payMethodIcon.icon,
                  color: isSelected ? Colors.white : Colors.black,
                ),
                Text(
                  payMethodName,
                  style: Styles.textStyle24.copyWith(
                    fontWeight: .w600,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
