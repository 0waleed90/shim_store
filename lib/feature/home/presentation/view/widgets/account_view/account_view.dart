import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/util/styles.dart';
import '../../../../../../core/util/widgets/custom_text_field.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Account ', style: Styles.textStyle32)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text('Your Name', style: Styles.textStyle16),
            CustomTextField(
              hintText: FirebaseAuth.instance.currentUser!.displayName!,
              readOnly: true,
            ),

            const SizedBox(height: 30),
            Text('Your Email', style: Styles.textStyle16),
            CustomTextField(
              hintText: FirebaseAuth.instance.currentUser!.email!,
              readOnly: true,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
