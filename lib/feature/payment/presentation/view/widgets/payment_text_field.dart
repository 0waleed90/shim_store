import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/cib.dart';
import 'package:iconify_flutter/icons/zondicons.dart';
import 'package:my_store/core/util/styles.dart';

class PaymentTextField extends StatelessWidget {
  const PaymentTextField({
    super.key,
    required this.cardNumber,
    required this.suffixIcon,
    required this.onSuffixIconPressed, required this.prefixIcon,
  });
  final String cardNumber;
  final Icon suffixIcon;
  final Iconify prefixIcon;
  final VoidCallback onSuffixIconPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child:Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: .circular(10),
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          children: [
            const SizedBox(width: 20,),
            prefixIcon,
            const SizedBox(width: 10),
             Text(cardNumber, style: Styles.textStyle22),
            const Spacer(),
            IconButton(onPressed: onSuffixIconPressed, icon: suffixIcon),
          ],
        ),
      ),
    );
  }
}
