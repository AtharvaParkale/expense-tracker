import 'package:expense_tracker_app/core/common/pages/splash_screen.dart';
import 'package:expense_tracker_app/dependency_manager/init_dependencies.dart';
import 'package:expense_tracker_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:expense_tracker_app/features/auth/presentation/pages/login_page.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:expense_tracker_app/features/statistics/presentation/bloc/statistics_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

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
  late final LocalAuthentication biometricAuth;
  bool _supportedState = false;
  bool _canCheckBiometrics = false;
  bool _shouldDisplaySplashScreen = true;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    biometricAuth = LocalAuthentication();
    _checkBiometricSupport();
    _handleSplashScreen();
  }

  void _checkBiometricSupport() async {
    final isSupported = await biometricAuth.isDeviceSupported();
    final canCheck = await biometricAuth.canCheckBiometrics;
    if (mounted) {
      setState(() {
        _supportedState = isSupported;
        _canCheckBiometrics = canCheck;
      });
    }
  }

  void _handleSplashScreen() async {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) setState(() => _shouldDisplaySplashScreen = false);

    _authenticate();
  }

  Future<void> _authenticate() async {
    try {
      final didAuthenticate = await biometricAuth.authenticate(
        localizedReason: 'Authenticate to access the app',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );

      if (mounted) {
        setState(() => _isAuthenticated = didAuthenticate);
      }
    } catch (e) {
      debugPrint('Authentication failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      home: _shouldDisplaySplashScreen
          ? const SplashScreen()
          : Stack(
              children: [
                _buildAppScreens(),
                if (!_isAuthenticated &&
                    (_supportedState || _canCheckBiometrics))
                  _buildLockOverlay(), // show overlay if not authenticated
              ],
            ),
    );
  }

  BlocSelector<AppUserCubit, AppUserState, bool> _buildAppScreens() {
    return BlocSelector<AppUserCubit, AppUserState, bool>(
      selector: (state) =>
          state is AppUserAuthenticated || state is AppUserLoggedIn,
      builder: (context, isLoggedIn) {
        if (isLoggedIn) return const StackHomeScreen();
        return const LoginPage();
      },
    );
  }

  Widget _buildLockOverlay() {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: _authenticate,
          icon: const Icon(Icons.fingerprint),
          label: const Text("Unlock with Biometrics or PIN"),
        ),
      ),
    );
  }
}
