import 'package:flutter/material.dart';

import '../../../../../../core/util/styles.dart';

class PriceDetails extends StatelessWidget {
  const PriceDetails({super.key, required this.leftText, required this.rightText});
final String leftText;
final String rightText;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            leftText,
            style: Styles.textStyle20.copyWith(
              fontWeight: FontWeight.w500,
              color: Color(0xff808080),
            ),
          ),
          Text(rightText, style: Styles.textStyle20),
        ],
      ),
    );;
  }
}
