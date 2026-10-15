import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/feature/payment/presentation/manger/address_cubit/address_cubit.dart';

import '../../../../../../core/util/styles.dart';
import '../../../../../../core/util/widgets/custom_text_field.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Account ', style: Styles.textStyle32)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            const SizedBox(height: 30, child: Divider()),
            const Text('Your Name', style: Styles.textStyle16),
            const SizedBox(height: 10),

            CustomTextField(
              hintText: FirebaseAuth.instance.currentUser!.displayName!,

              readOnly: true,
            ),

            const SizedBox(height: 30),
            const Text('Your Email', style: Styles.textStyle16),
            const SizedBox(height: 10),

            CustomTextField(
              hintText: FirebaseAuth.instance.currentUser!.email!,
              readOnly: true,
            ),
            const SizedBox(height: 30),
            const Text('Your Address', style: Styles.textStyle16),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: context.read<AddressCubit>().fullAddress,

              readOnly: true,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
