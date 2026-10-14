import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/util/app_router.dart';
import 'package:my_store/core/util/styles.dart';
import 'package:my_store/feature/sign_in_log_in/presentation/manger/auth_cubit.dart';
import 'package:my_store/feature/sign_in_log_in/presentation/view/widgets/enter_option.dart';
import '../../../../../core/util/widgets/custom_text_field.dart';
import '../../manger/auth_state.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          GoRouter.of(context).go(AppRouter.kHomeView);
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                const Text('Create an account', style: Styles.textStyle32),
                Text(
                  'Lets create your account',
                  style: Styles.textStyle16.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 30),
                const Text('Full Name', style: Styles.textStyle16),
                CustomTextField(
                  controller: nameController,
                  hintText: 'Enter your full name',
                  readOnly: false,
                ),
                const SizedBox(height: 20),
                const Text('Email', style: Styles.textStyle16),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Enter your email address',
                  readOnly: false,
                ),
                const SizedBox(height: 20),
                const Text('Password', style: Styles.textStyle16),
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Enter your Password',
                  readOnly: false,
                ),
                const SizedBox(height: 15),
                const Text(
                  'By signing up you agree to our Terms, Privacy Policy, and Cookie Use',
                ),
                const SizedBox(height: 30),
                state is AuthLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      )
                    : EnterOption(
                        normalEnterOnTap: () {
                          final name = nameController.text.trim();
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();
                          if (name.isEmpty ||
                              email.isEmpty ||
                              password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('الرجاء ملء الحقول أولاً'),
                              ),
                            );
                            return;
                          }
                          context.read<AuthCubit>().createUserWithEmail(
                            email,
                            password,
                            name,
                          );
                        },
                        normalEnterButtonText: 'Create an account',
                      ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(color: Color(0xff7E7E7E)),
                    ),
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.kLogInView);
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1A1A1A),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        );
      },
    );
  }
}
