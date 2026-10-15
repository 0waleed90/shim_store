import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/util/styles.dart';
import 'package:my_store/feature/home/data/models/product_model/product_model.dart';
import 'package:my_store/feature/home/presentation/manger/product_cubit/product_cubit.dart';
import 'package:my_store/feature/home/presentation/view/widgets/my_cart_view/count_control_widget.dart';

class CartProductListViewItem extends StatelessWidget {
  const CartProductListViewItem({super.key, required this.product, required this.index,  required this.cartItemCount});
  final ProductModel product;
  final int index;
final int cartItemCount;
  @override
  Widget build(BuildContext context) {
    String imageUrl = '';
    if (product.images != null && product.images!.isNotEmpty) {
      imageUrl = product.images!.first;
      imageUrl = imageUrl.replaceAll(RegExp(r'[\[\]"]'), '');
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: .circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          size: 40,
                          color: Colors.grey,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    },
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                width: 160,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(product.title, style: Styles.textStyle14,),
                    const Text('product.size!'),
                    const SizedBox(height: 30),
                    Text('${product.price}\$', style: Styles.textStyle14,),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: .end,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<ProductCubit>().removeFromCart(
                      product.id,
                      product.title,
                      product.price,
                      product.description,
                      product.category,
                      product.images!,

                    );
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
                const SizedBox(height: 20),
                CountControlWidget(
                  index: index,
                  cartItemCount: product.quantity,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
