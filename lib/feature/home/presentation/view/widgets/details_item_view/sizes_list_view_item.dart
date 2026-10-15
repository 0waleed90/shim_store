import 'package:flutter/material.dart';

import '../../../../../../core/util/styles.dart';

class SizesListViewItem extends StatelessWidget {
  const SizesListViewItem({
    super.key,
    required this.size,
    required this.isSelected,
    required this.onTap,
  });
  final String size;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          height: 50,
          width: 47,
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: .circular(10),
          ),

          child:  Center(
            child: Text(
              size,
              style: Styles.textStyle24.copyWith(
                fontWeight: .w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
