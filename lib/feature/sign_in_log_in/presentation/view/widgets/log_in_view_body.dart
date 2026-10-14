import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/feature/sign_in_log_in/presentation/manger/auth_cubit.dart';
import 'package:my_store/feature/sign_in_log_in/presentation/view/widgets/enter_option.dart';
import '../../../../../core/util/app_router.dart';
import '../../../../../core/util/styles.dart';
import '../../../../../core/util/widgets/custom_text_field.dart';
import '../../manger/auth_state.dart';

class LogInViewBody extends StatefulWidget {
  const LogInViewBody({super.key});

  @override
  State<LogInViewBody> createState() => _LogInViewBodyState();
}

class _LogInViewBodyState extends State<LogInViewBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
        return SingleChildScrollView( // 👈 استخدام SingleChildScrollView هنا أيضاً
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                const Text('Login to your account', style: Styles.textStyle32),
                const SizedBox(height: 10),
                Text(
                  'It’s great to see you again.',
                  style: Styles.textStyle16.copyWith(fontSize: 22, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 30),
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
                Row(
                  children: [
                    const Text(
                      'Forgot your password?  ',
                      style: TextStyle(color: Color(0xff7E7E7E)),
                    ),
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.kRestPasswordView);
                      },
                      child: const Text(
                        'Reset your password',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff1A1A1A)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                state is AuthLoading
                    ? const Center(child: CircularProgressIndicator(color: Colors.black))
                    : EnterOption(
                        normalEnterOnTap: () {
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();
                          if (email.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('الرجاء ملء الحقول أولاً')),
                            );
                            return;
                          }
                          context.read<AuthCubit>().logIn(email, password);
                        }, normalEnterButtonText: 'log in',
                      ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don’t have an account? ',
                      style: TextStyle(color: Color(0xff7E7E7E)),
                    ),
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).pop();
                      },
                      child: const Text(
                        'Join',
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
