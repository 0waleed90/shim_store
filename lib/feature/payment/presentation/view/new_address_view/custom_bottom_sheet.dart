import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/util/app_router.dart';
import 'package:my_store/feature/payment/presentation/manger/address_cubit/address_cubit.dart';

import '../../../../../core/util/styles.dart';
import '../../../../../core/util/widgets/custom_button.dart';
import '../../../../../core/util/widgets/custom_text_field.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key, required this.fullAddressText});
  final String fullAddressText;
  @override
  Widget build(BuildContext context) {
    String addressNickName = 'Home';
    return SizedBox(
      height: 390,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text('Address', style: Styles.textStyle22),
                IconButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  icon: const Icon(Icons.close, size: 33),
                ),
              ],
            ),
            SizedBox(height: 20, child: Divider()),
            Text(
              'Address Nickname',
              style: Styles.textStyle20.copyWith(fontWeight: .w400),
            ),
            SizedBox(height: 10),
            CustomTextField(
              hintText: 'Home',
              readOnly: false,
              onChanged: (value) {
                addressNickName = value;
              },
            ),
            SizedBox(height: 10),
            SizedBox(height: 20, child: Divider()),
            Text(
              'Full Address',
              style: Styles.textStyle20.copyWith(fontWeight: .w400),
            ),
            SizedBox(height: 10),
            CustomTextField(hintText: fullAddressText, readOnly: true),
            Spacer(),
            CustomButton(
              text: 'Add',
              color: Colors.black,
              textColor: Colors.white,
              width: 500,
              onTap: () {
                context.read<AddressCubit>().addNewAddress(
                  addressNickName,
                  fullAddressText,
                );
                GoRouter.of(context).pop();
                GoRouter.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
