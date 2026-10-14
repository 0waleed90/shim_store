import 'package:flutter/material.dart';
import 'package:my_store/core/util/styles.dart';

class EmptySearch extends StatelessWidget {
  const EmptySearch({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      children: [
        Icon(
          size: 64,
          color: Color(0xff979797),
          Icons.youtube_searched_for_rounded,
        ),
        Text('No Results Found!', style: Styles.textStyle24),
        Text(
          'Try a similar word or something more general.',
          style: Styles.textStyle20,textAlign: .center,
        ),
      ],
    );
  }
}
