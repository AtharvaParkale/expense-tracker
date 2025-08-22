import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:expense_tracker_app/core/utils/custom_page_router.dart';
import 'package:expense_tracker_app/core/utils/show_bottomsheet.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/widgets/add_expense_bottomsheet.dart';
import 'package:expense_tracker_app/features/statistics/presentation/screens/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          onPressed: () {
            openBottomSheet(
              context,
              AddExpenseBottomSheet(
                onSubmit: (title, category, amount) {
                  context.read<DashboardBloc>().add(
                    AddExpenseEvent(
                      amount: amount,
                      title: title,
                      category: category,
                    ),
                  );
                },
              ),
            );
          },
          backgroundColor: AppPallete.bgBlack,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppPallete.whiteColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: _buildBottomNavItem(context, 'Home', Icons.home, 0),
            ),
            const SizedBox(width: 40), 
            Expanded(
              child: _buildBottomNavItem(context, 'Stats', Icons.bar_chart, 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
    BuildContext context,
    String label,
    IconData icon,
    int index,
  ) {
    return MaterialButton(
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
          const SizedBox(height: 2),
          Text(
            label,
            style:
                (Theme.of(context).textTheme.bodySmall ??
                        const TextStyle(fontSize: 12))
                    .copyWith(
                      fontWeight: FontWeight.w600,
                      color: _selectedIndex == index
                          ? AppPallete.primaryColor
                          : Colors.blueGrey,
                    ),
          ),
        ],
      ),
    );
  }
}
