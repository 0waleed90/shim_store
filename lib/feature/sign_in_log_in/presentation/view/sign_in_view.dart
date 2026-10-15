import 'package:flutter/material.dart';
import 'package:my_store/feature/sign_in_log_in/presentation/view/widgets/sign_in_view_body.dart';
class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

        body:  SignInViewBody());
  }
}
