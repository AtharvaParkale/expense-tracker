import 'package:expense_tracker_app/core/constants/app_enums.dart';

class User {
  final String id;
  final String email;
  final String name;
  final OnboardingStatus? onBoardingStatus;
  final int? age;
  final String? gender;
  final int? height;
  final int? maintenanceCalories;
  final int? goalCalories;
  final int? goalProtein;
  final double? weight;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.onBoardingStatus,
    this.age,
    this.gender,
    this.height,
    this.maintenanceCalories,
    this.goalCalories,
    this.goalProtein,
    this.weight,
  });
}
