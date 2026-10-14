import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/util/styles.dart';
import 'package:my_store/feature/home/presentation/manger/product_cubit/product_cubit.dart';

class CountControlWidget extends StatelessWidget {
  const CountControlWidget({super.key, required this.index, required this.cartItemCount});
  final int index;
  final int cartItemCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        operator('-', () {
          context.read<ProductCubit>().decreaseCartItemCount(index);
        }),
        const SizedBox(width: 10),
        Text(cartItemCount.toString(), style: Styles.textStyle14),
        const SizedBox(width: 10),
        operator('+', () {
          context.read<ProductCubit>().increaseCartItemCount(index);
        }),
        const SizedBox(width: 10),
      ],
    );
  }

  GestureDetector operator(String opr, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 23,
        width: 23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.black),
        ),
        child: Center(child: Text(opr)),
      ),
    );
  }
}
