import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:hive/hive.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends Expense {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final String userId;

  @HiveField(2)
  @override
  final String category;

  @HiveField(3)
  @override
  final String title;

  @HiveField(4)
  @override
  final double amount;

  @HiveField(5)
  @override
  final String createdAt;

  ExpenseModel({
    required this.id,
    required this.userId,
    required this.category,
    required this.title,
    required this.amount,
    required this.createdAt,
  }) : super(
         id: id,
         userId: userId,
         category: category,
         title: title,
         amount: amount,
         createdAt: createdAt,
       );

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      category: json['category'] ?? '',
      title: json['title'] ?? '',
      amount: json['amount'] ?? 0,
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'category': category,
      'title': title,
      'amount': amount,
      'created_at': createdAt,
    };
  }
}
