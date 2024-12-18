import 'package:flutter/material.dart';
import 'package:wheelmap/common/constants/app_constants.dart';
import 'package:wheelmap/common/extensions/parse_tab_name_to_string.dart';
import 'package:wheelmap/presentation/common_widgets/custom_appbar.dart';
import 'package:wheelmap/presentation/discover/discover_view.dart';
import 'package:wheelmap/presentation/favourites/favourites_view.dart';
import 'package:wheelmap/presentation/plan/plan_view.dart';
import 'package:latlong2/latlong.dart' as latlong2;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> {
  /// Currently selected bottom bar's index
  int _selectedIndex = 0;

  /// Titles for the pages..
  final List<String> _titles = [
    TabName.discover.capitalize(),
    TabName.favourites.capitalize()
  ];

  /// Main pages for each tab/bottom
  final List<Widget> _pages = [
    const DiscoverView(),
    const FavouritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: _titles[_selectedIndex]),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBarItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.star),
            label: TabName.discover.capitalize(),
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.favorite),
              label: TabName.favourites.capitalize()),
        ],
      ),
    );
  }

  void _onBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
