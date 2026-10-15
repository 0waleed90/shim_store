import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_store/core/util/api_service.dart';
import 'package:my_store/feature/home/data/repo/product_repo/product_repo_impl.dart';
import 'package:my_store/feature/home/presentation/manger/product_cubit/product_cubit.dart';
import 'package:my_store/feature/home/presentation/manger/search_cubit/search_cubit.dart';
import 'package:my_store/feature/payment/presentation/manger/address_cubit/address_cubit.dart';
import 'package:my_store/feature/payment/presentation/manger/card_cubit/card_cubit.dart';
import 'package:my_store/feature/sign_in_log_in/data/repo/auth_repo_impl.dart';
import 'package:my_store/feature/sign_in_log_in/presentation/manger/auth_cubit.dart';
import 'package:my_store/firebase_options.dart';
import 'core/util/app_router.dart';
import 'core/util/hive_boxes.dart';

bool isLogin = false;
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  var box = await Hive.openBox(HiveBoxes.basicBox);
  isLogin = box.get(HiveBoxes.kIsLoginBox, defaultValue: false);
  runApp(const MyStore());
}

class MyStore extends StatelessWidget {
  const MyStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(authRepo: AuthRepoImpl())),
        BlocProvider(
          create: (context) =>
              ProductCubit(
                  productRepo: ProductRepoImpl(apiService: ApiService(Dio())),
                )
                ..fetchProducts()
                ..getSavedItems()
                ..getCartItems(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(
            productRepo: ProductRepoImpl(apiService: ApiService(Dio())),
          ),
        ),
        BlocProvider(create: (context) => AddressCubit()..getAddress()),
        BlocProvider(create: (context) => CardCubit()..getCard()..getSelectPay()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}

