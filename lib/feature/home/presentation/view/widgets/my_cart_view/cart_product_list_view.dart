import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/feature/home/presentation/manger/product_cubit/product_cubit.dart';
import 'package:my_store/feature/home/presentation/manger/product_cubit/product_state.dart';
import 'package:my_store/feature/home/presentation/view/widgets/my_cart_view/empty_cart.dart';

import '../../../../../../core/util/styles.dart';
import '../../../../../../core/util/widgets/custom_button.dart';
import 'cart_product_list_view_item.dart';

class CartProductListView extends StatelessWidget {
  const CartProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductSuccess) {
            if (state.cartItems.isEmpty) {
              return EmptyCart();
            }
            return ListView.builder(
              itemCount: state.cartItems.length,
              itemBuilder: (context, index) {
                return CartProductListViewItem(
                  product: state.cartItems[index],
                  index: index,
                  cartItemCount: state.cartItemCount,
                );
              },
            );
          } else if (state is ProductFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                  SizedBox(height: 16),

                  Text(
                    state.errorMessage,
                    style: Styles.textStyle20,
                    textAlign: .center,
                  ),

                  SizedBox(height: 16),
                  CustomButton(
                    text: 'Retry',
                    color: Colors.black,
                    textColor: Colors.white,
                    width: 500,
                    onTap: () {
                      context.read<ProductCubit>().fetchProducts();
                    },
                  ),
                ],
              ),
            );
          } else if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return EmptyCart();
          }
        },
      ),
    );
  }
}
