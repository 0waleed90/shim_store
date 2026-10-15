import 'package:flutter/material.dart';
import 'package:my_store/feature/home/presentation/view/widgets/account_view/account_view.dart';
import 'package:my_store/feature/home/presentation/view/widgets/discover_view/discover_view.dart';
import 'package:my_store/feature/home/presentation/view/widgets/my_cart_view/my_cart_view.dart';
import 'package:my_store/feature/home/presentation/view/widgets/saved_view/saved_view.dart';
import 'package:my_store/feature/home/presentation/view/widgets/search_view/search_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;

  void onItemTaped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  late final List<Widget> _pages = [
    const DiscoverView(),
    const SearchView(),
    const SavedView(),
    const MyCartView(),
    const AccountView(),
  ];
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onItemTaped,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home_outlined, color: Colors.black),
            icon: Icon(Icons.home_outlined, color: Color(0xff979797)),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.search, color: Colors.black),
            icon: Icon(Icons.search, color: Color(0xff979797)),
            label: 'Search',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.favorite_border, color: Colors.black),
            icon: Icon(Icons.favorite_border, color: Color(0xff979797)),
            label: 'Saved',
          ),
          NavigationDestination(

            selectedIcon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
            icon: Icon(Icons.shopping_cart_outlined, color: Color(0xff979797)),
            label: 'My Cart',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.account_circle_outlined,
              color: Colors.black,
            ),
            icon: Icon(Icons.account_circle_outlined, color: Color(0xff979797)),
            label: 'Account',
          ),
        ],
      ),

      body: _pages[selectedIndex],
    );
  }
}
