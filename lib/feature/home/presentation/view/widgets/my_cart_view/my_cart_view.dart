import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/util/app_router.dart';
import 'package:my_store/core/util/styles.dart';
import 'package:my_store/core/util/widgets/custom_button.dart';
import 'package:my_store/feature/home/presentation/manger/product_cubit/product_cubit.dart';
import 'package:my_store/feature/home/presentation/manger/product_cubit/product_state.dart';
import 'package:my_store/feature/home/presentation/view/widgets/my_cart_view/price_detils.dart';

import 'cart_product_list_view.dart';

class MyCartView extends StatelessWidget {
  const MyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Scaffold(
        appBar: AppBar(title: Text('My Cart', style: Styles.textStyle32)),
        body:BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            int total = context.read<ProductCubit>().getTotalOfCartItem();
            return  SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CartProductListView(),
                  PriceDetails(
                    leftText: 'Sub-total',
                    rightText:"${total.toString()} \$",
                  ),
                  const PriceDetails(leftText: 'VAT (%)', rightText: r'0.00 $'),
                  const PriceDetails(leftText: 'Shipping fee', rightText: r'0 $'),
              
                  SizedBox(
                      height: 20,
                      child: const Divider()),
                  PriceDetails(leftText: 'Total', rightText: "${total.toString()} \$"),
              
                  const SizedBox(height: 40),
                  CustomButton(
                    text: 'Go To Checkout',
                    color: Colors.black,
                    textColor: Colors.white,
                    width: 500,
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kCheckoutView,extra: total);
                    },
                  ),const SizedBox(height: 30,)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
