import 'package:flutter/material.dart';

import '../../../../../../core/util/styles.dart';
    class EmptyCart extends StatelessWidget {
      const EmptyCart({super.key});
    
      @override
      Widget build(BuildContext context) {
        return const Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Icon(
              size: 64,
              color: Color(0xff979797),
              Icons.shopping_cart_outlined,
            ),
            Text('Your Cart Is Empty!', style: Styles.textStyle24),
            Text(
              'When you add products, they’ll appear here.',
              style: Styles.textStyle20,
              textAlign: .center,
            ),
          ],
        );
      }
    }
    