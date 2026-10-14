import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/util/styles.dart';

import '../../../../../../core/util/widgets/custom_button.dart';
import '../../../manger/product_cubit/product_cubit.dart';
import '../../../manger/product_cubit/product_state.dart';
import 'grid_view_item.dart';

class CustomDiscoverGridView extends StatelessWidget {
  const CustomDiscoverGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductSuccess) {
          return GridView.builder(
            itemCount: state.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.65,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return GridViewItem(product: state.products[index]);
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
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
