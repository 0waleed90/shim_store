import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_store/core/util/hive_boxes.dart';
import 'package:my_store/feature/splash/presentation/view/widgets/line_image.dart';

import '../../../../../core/util/app_router.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    bool isLogin=Hive.box(HiveBoxes.basicBox).get(HiveBoxes.kIsLoginBox,defaultValue: false);

    
    Future.delayed(const Duration(seconds: 3), () {
      isLogin ?GoRouter.of(context).go(AppRouter.kHomeView):
      GoRouter.of(context).go(AppRouter.kOnboardingView);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Align(alignment: .xy(0, -0.8), child: LineImage()),
        const Align(alignment: .xy(0, -0.6), child: LineImage()),
        const Align(alignment: .xy(0, -0.4), child: LineImage()),
        const Align(alignment: .xy(0, -0.2), child: LineImage()),
        Align(
          alignment: const .xy(0, 0),
          child: Image.asset('assets/photo/logo.png'),
        ),
        const Align(
          alignment: .xy(0, 0.8),
          child: CircularProgressIndicator(
            strokeWidth: 10,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
