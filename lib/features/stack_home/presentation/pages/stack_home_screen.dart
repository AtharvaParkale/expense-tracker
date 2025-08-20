import 'package:expense_tracker_app/core/constants/app_font_weigth.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:expense_tracker_app/core/theme/app_text_theme.dart';
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

  final List<Widget> widgetOptions = const [
    DashboardScreen(),
    StatisticsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppPallete.secondaryColor,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.qr_code_scanner,
            color: Colors.white,
            size: 36,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppPallete.primaryColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  _buildBottomNavItem('Home', Icons.home, 0),
                ],
              ),
              Row(
                children: [
                  _buildBottomNavItem('Stats', Icons.fastfood, 1),
                ],
              ),
            ],
          ),
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
                ? AppPallete.secondaryColor
                : Colors.blueGrey,
          ),
          Text(
            label,
            style: appTextTheme.bodySmall?.copyWith(
              fontWeight: AppFontWeight.semiBold,
              color: _selectedIndex == index
                  ? AppPallete.secondaryColor
                  : Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }
}
