import 'package:flutter/material.dart';

import 'cards_list_view_item.dart';

class CardListView extends StatefulWidget {
  const CardListView({super.key, required this.onPaySelected});
  final ValueChanged<String> onPaySelected;
  @override
  State<CardListView> createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView> {
  final List<Icon> paymentIcons = [
    Icon(Icons.credit_card),
    Icon(Icons.money),
    Icon(Icons.paypal),
  ];
  final List<String> paymentMethod = ['card', 'cash', 'paypal'];
  int selectedPayIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: paymentMethod.length,
        itemBuilder: (context, index) {
          return CardsListViewItem(
            onTap: () {setState(() {
              selectedPayIndex=index;
            });},
            isSelected: selectedPayIndex == index,
            payMethodName: paymentMethod[index], payMethodIcon: paymentIcons[index],
          );
        },
      ),
    );
  }
}
