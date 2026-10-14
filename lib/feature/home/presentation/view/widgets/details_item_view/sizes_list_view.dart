import 'package:flutter/material.dart';
import 'package:my_store/feature/home/presentation/view/widgets/details_item_view/sizes_list_view_item.dart';

class SizesListView extends StatefulWidget {
  const SizesListView({super.key, required this.onSizeSelected});
  final ValueChanged<String> onSizeSelected;
  @override
  State<SizesListView> createState() => _SizesListViewState();
}

class _SizesListViewState extends State<SizesListView> {
  final List<String> sizes = ['S', 'M', 'L', 'XL'];
  int selectedSizeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        itemCount: sizes.length,
        scrollDirection: .horizontal,
        itemBuilder: (context, index) {
          return SizesListViewItem(
            size: sizes[index],
            isSelected: selectedSizeIndex == index,
            onTap: () {
              setState(() {
                selectedSizeIndex = index;
              });
            },
          );
        },
      ),
    );
  }
}
