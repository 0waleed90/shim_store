import 'package:flutter/material.dart';

import '../../../../../../core/util/styles.dart';
class EmptySavedItem extends StatelessWidget {
  const EmptySavedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      children: [
        Icon(
          size: 64,
          color: Color(0xff979797),
          Icons.favorite_border,
        ),
        Text('No Saved Items!', style: Styles.textStyle24),
        Text(
          'You don’t have any saved items. Go to home and add some.',
          style: Styles.textStyle20,textAlign: .center,
        ),
      ],
    );
  }
}
