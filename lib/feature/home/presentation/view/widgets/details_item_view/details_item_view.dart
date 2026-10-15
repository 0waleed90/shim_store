import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/util/widgets/custom_button.dart';
import 'package:my_store/feature/home/data/models/product_model/product_model.dart';
import 'package:my_store/feature/home/presentation/view/widgets/details_item_view/sizes_list_view.dart';

import '../../../../../../core/util/styles.dart';
import '../../../manger/product_cubit/product_cubit.dart';

class DetailsItemView extends StatelessWidget {
  const DetailsItemView({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    bool isSaved = false;
    List<ProductModel> savedItems = context.watch<ProductCubit>().savedItems;

    for (int i = 0; i < savedItems.length; i++) {
      if (savedItems[i].title == product.title &&
          savedItems[i].price == product.price &&
          savedItems[i].description == product.description &&
          savedItems[i].category == product.category) {
        isSaved = true;
      }
    }
    String selectedSize = 's';
    String imageUrl = '';
    if (product.images != null && product.images!.isNotEmpty) {
      imageUrl = product.images!.first;
      imageUrl = imageUrl.replaceAll(RegExp(r'[\[\]"]'), '');
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Details', style: Styles.textStyle32),
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () {
                        isSaved
                            ? context.read<ProductCubit>().removeFromSaved(
                                product.id,
                                product.title,
                                product.price,
                                product.description,
                                product.category,
                                product.images!,
                              )
                            : context.read<ProductCubit>().addToSaved(
                                product.id,
                                product.title,
                                product.price,
                                product.description,
                                product.category,
                                product.images!,
                              );
                      },
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),

                        child: Icon(
                          color: isSaved ? Colors.red : Colors.black,
                          isSaved ? Icons.favorite : Icons.favorite_border,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(product.title, style: Styles.textStyle24),
              const SizedBox(height: 10),

              const Row(
                children: [
                  Icon(Icons.star, color: Color(0xffFCA728)),
                  Text('4.0/5', style: Styles.textStyle14),
                  Text(' (45 reviews)'),
                ],
              ),
              const SizedBox(height: 10),

              Text(product.description),
              const SizedBox(height: 10),
              const Text('Choose size', style: Styles.textStyle24),
              const SizedBox(height: 10),
              SizesListView(
                onSizeSelected: (size) {
                  selectedSize = size;
                },
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Price'),
                      Text(
                        '\$${product.price.toString()}',
                        style: Styles.textStyle24,
                      ),
                    ],
                  ),

                  CustomButton(
                    icon: Icons.shopping_bag,
                    text: 'Add to Cart',
                    color: Colors.black,
                    textColor: Colors.white,
                    width: 240,
                    onTap: () {
                      bool isInCart = false;
                      List<ProductModel> cartItems = context
                          .read<ProductCubit>()
                          .cartItems;
                      for (int i = 0; i < cartItems.length; i++) {
                        if (cartItems[i].title == product.title &&
                            cartItems[i].price == product.price &&
                            cartItems[i].description == product.description &&
                            cartItems[i].category == product.category) {
                          isInCart = true;
                        }
                      }
                      isInCart
                          ? ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'هذا العنصر مضاف بالفعل الى السلة',
                                ),
                              ),
                            )
                          : {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('تم اضافة العنصر')),
                              ),

                              context.read<ProductCubit>().addToCart(
                                product.id,
                                product.title,
                                product.price,

                                product.description,
                                product.category,
                                product.images!,
                                selectedSize,
                              ),
                            };
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
