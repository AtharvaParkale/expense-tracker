import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:expense_tracker_app/core/utils/custom_page_router.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:expense_tracker_app/features/statistics/presentation/screens/statistics_screen.dart';
import 'package:flutter/material.dart';

class StackHomeScreen extends StatefulWidget {
  static route() =>
      CustomPageRoute.route(const StackHomeScreen(), PageRouteDirection.LEFT);

  const StackHomeScreen({super.key});

  @override
  State<StackHomeScreen> createState() => _StackHomeScreenState();
}

class _StackHomeScreenState extends State<StackHomeScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  final List<Widget> widgetOptions = const [
    DashboardScreen(),
    StatisticsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: widgetOptions,
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppPallete.bgBlack,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppPallete.whiteColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [_buildBottomNavItem('Home', Icons.home, 0)],
            ),
            const SizedBox(width: 40),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [_buildBottomNavItem('Stats', Icons.bar_chart, 1)],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(String label, IconData icon, int index) {
    return MaterialButton(
      minWidth: 40,
      onPressed: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: _selectedIndex == index
                ? AppPallete.primaryColor
                : Colors.blueGrey,
            size: 27,
          ),
        ],
      ),
    );
  }
}
