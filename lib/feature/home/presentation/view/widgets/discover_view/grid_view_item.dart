import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/util/app_router.dart';
import 'package:my_store/core/util/styles.dart';
import 'package:my_store/feature/home/data/models/product_model/product_model.dart';

import '../../../manger/product_cubit/product_cubit.dart';

class GridViewItem extends StatelessWidget {
  const GridViewItem({super.key, this.product});
  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    bool isSaved = false;
    List<ProductModel> savedItems = context.watch<ProductCubit>().savedItems;

    String imageUrl = '';
    if (product!.images != null && product!.images!.isNotEmpty) {
      imageUrl = product!.images!.first;
      imageUrl = imageUrl.replaceAll(RegExp(r'[\[\]"]'), '');
    }
    for (int i = 0; i < savedItems.length; i++) {
      if (savedItems[i].title == product!.title &&
          savedItems[i].price == product!.price &&
          savedItems[i].description == product!.description &&
          savedItems[i].category == product!.category) {
        isSaved = true;
      }
    }
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.kDetailsItemView, extra: product);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.grey[200],
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
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      isSaved
                          ? context.read<ProductCubit>().removeFromSaved(
                              product!.id,
                              product!.title,
                              product!.price,
                              product!.description,
                              product!.category,
                              product!.images ?? const [],
                            )
                          : context.read<ProductCubit>().addToSaved(
                              product!.id,
                              product!.title,
                              product!.price,
                              product!.description,
                              product!.category,
                              product!.images ?? const [],
                            );
                    },
                    child: Container(
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        size: 18,
                        isSaved ? Icons.favorite : Icons.favorite_border,
                        color: isSaved ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            product!.title,
            style: Styles.textStyle16,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            '\$${product!.price.toString()}',
            style: Styles.textStyle14.copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
