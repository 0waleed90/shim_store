import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/util/widgets/custom_button.dart';
import 'package:my_store/feature/sign_in_log_in/presentation/manger/auth_state.dart';

import '../../../../../core/util/styles.dart';
import '../../../../../core/util/widgets/custom_text_field.dart';
import '../../manger/auth_cubit.dart';

class RestPasswordViewBody extends StatefulWidget {
  const RestPasswordViewBody({super.key});

  @override
  State<RestPasswordViewBody> createState() => _RestPasswordViewBodyState();
}

class _RestPasswordViewBodyState extends State<RestPasswordViewBody> {
  final TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              const Text('Forgot password', style: Styles.textStyle32),
              Text(
                'Enter your email for the verification process. We will send 4 digits code to your email.',
                style: Styles.textStyle16.copyWith(
                  fontSize: 22,
                  fontWeight: .w400,
                ),
              ),
              const SizedBox(height: 30),
              const Text('Email', style: Styles.textStyle16),
              CustomTextField(
                controller: emailController,
                hintText: 'Enter your email address',
                readOnly: false,
              ),
              const Spacer(),
              state is AuthLoading
                  ? CircularProgressIndicator()
                  : CustomButton(
                      text: 'send email',
                      color: Colors.black,
                      textColor: Colors.white,
                      width: 500,
                      onTap: () {
                        final email = emailController.text.trim();
                        if (email.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('الرجاء ملء الحقول أولاً'),
                            ),
                          );
                          return;
                        }
                        context.read<AuthCubit>().resetPassword(email);
                      },
                    ),
              const SizedBox(height: 25),
              CustomButton(
                text: 'return to login page',
                color: Colors.black,
                textColor: Colors.white,
                width: 500,
                onTap: () {
                  GoRouter.of(context).pop();
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        );
      },
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state is AuthPasswordResetSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
    );
  }
}
