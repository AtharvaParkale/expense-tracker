import 'package:expense_tracker_app/core/common/pages/splash_screen.dart';
import 'package:expense_tracker_app/dependency_manager/init_dependencies.dart';
import 'package:expense_tracker_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:expense_tracker_app/features/auth/presentation/pages/login_page.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:expense_tracker_app/features/statistics/presentation/bloc/statistics_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'features/stack_home/presentation/pages/stack_home_screen.dart'
    show StackHomeScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<DashboardBloc>()),
        BlocProvider(create: (_) => serviceLocator<StatisticsBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _shouldDisplaySplashScreen = true;

  @override
  void initState() {
    super.initState();
    _handleSplashScreen();
  }

  void _handleSplashScreen() async {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _shouldDisplaySplashScreen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      home: _shouldDisplaySplashScreen
          ? const SplashScreen()
          : _buildAppScreens(),
    );
  }

  BlocSelector<AppUserCubit, AppUserState, bool> _buildAppScreens() {
    return BlocSelector<AppUserCubit, AppUserState, bool>(
      selector: (state) {
        return state is AppUserAuthenticated || state is AppUserLoggedIn;
      },
      builder: (context, isLoggedIn) {
        if (isLoggedIn) {
          return const StackHomeScreen();
        }
        return const LoginPage();
      },
    );
  }
}
