import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/styles.dart';
import '../../../../../core/util/widgets/custom_button.dart';
import '../../manger/auth_cubit.dart';

class EnterOption extends StatelessWidget {
  const EnterOption({
    super.key,
    required this.normalEnterOnTap,
    required this.normalEnterButtonText,
  });
  final VoidCallback normalEnterOnTap;
  final String normalEnterButtonText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          text: normalEnterButtonText,
          color: const Color(0xffCACACA),
          textColor: Colors.white,
          width: 500,
          onTap: () {
            normalEnterOnTap();
          },
        ),
        const SizedBox(height: 25),
        Row(
          children: [
            const Expanded(
              child: Divider(
                thickness: 2,
                color: Colors.black,
                indent: 0,
                endIndent: 10,
              ),
            ),
            Text(
              'Or',
              style: Styles.textStyle20.copyWith(fontWeight: FontWeight.w400),
            ),
            const Expanded(
              child: Divider(
                thickness: 2,
                color: Colors.black,
                indent: 10,
                endIndent: 0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        CustomButton(
          icon: Icons.gite_outlined,
          text: 'Sign Up with Google',
          color: Colors.white,
          textColor: Colors.black,
          width: 500,
          borderColor: Colors.black12,
          onTap: () {
            context.read<AuthCubit>().signInWithGoogle();
          },
        ),
        const SizedBox(height: 20),
        CustomButton(
          icon: Icons.gite_outlined,
          text: 'Sign Up with Facebook',
          color: Colors.blue,
          textColor: Colors.white,

          width: 500,
          borderColor: Colors.black12,
          onTap: () {},
        ),
      ],
    );
  }
}
