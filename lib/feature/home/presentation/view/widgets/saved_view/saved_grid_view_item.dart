import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/feature/home/presentation/manger/product_cubit/product_cubit.dart';

import '../../../../../../core/util/app_router.dart';
import '../../../../../../core/util/styles.dart';
import '../../../../data/models/product_model/product_model.dart';

class SavedGridViewItem extends StatelessWidget {
  const SavedGridViewItem({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    String imageUrl = '';
    if (product.images != null && product.images!.isNotEmpty) {
      imageUrl = product.images!.first;
      imageUrl = imageUrl.replaceAll(RegExp(r'[\[\]"]'), '');
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
                      context.read<ProductCubit>().removeFromSaved(
                        product.id,
                        product.title,
                        product.price,
                        product.description,
                        product.category,
                        product.images!,
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
                      child: const Icon(
                        size: 18,
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            product.title,
            style: Styles.textStyle16,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            '\$${product.price.toString()}',
            style: Styles.textStyle14.copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
