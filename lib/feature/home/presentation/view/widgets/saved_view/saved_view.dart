import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/feature/home/presentation/manger/product_cubit/product_cubit.dart';
import 'package:my_store/feature/home/presentation/view/widgets/saved_view/empty_saved_item.dart';
import 'package:my_store/feature/home/presentation/view/widgets/saved_view/saved_grid_view_item.dart';

import '../../../../../../core/util/styles.dart';
import '../../../../../../core/util/widgets/custom_button.dart';
import '../../../manger/product_cubit/product_state.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Saved Items', style: Styles.textStyle32)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductSuccess) {
                if (state.savedItems.isEmpty) {
                  return EmptySavedItem();
                }
                return GridView.builder(
                  itemCount:state.savedItems.length ,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return SavedGridViewItem(
                      product: context.read<ProductCubit>().savedItems[index],
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
                return CircularProgressIndicator();
              } else {
                return EmptySavedItem();
              }
            },
          ),
        ),
      ),
    );
  }
}
