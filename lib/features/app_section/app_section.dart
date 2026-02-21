import 'package:flutter/material.dart';
import 'package:movie/features/app_section/widgets/custom_bottom_nav_bar.dart';

import 'package:movie/features/home/presentation/view/home_screen.dart';
import 'package:movie/features/search/presentation/pages/search_screen.dart';
import 'package:movie/features/watch_list/presentation/pages/watch_list_screen.dart';

class AppSection extends StatefulWidget {
  const AppSection({super.key});
  static const routeName = '/app';

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    SearchScreen(),
    WatchListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
