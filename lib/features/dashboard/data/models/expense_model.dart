import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';

class ExpenseModel extends Expense {
  ExpenseModel({
    required super.id,
    required super.userId,
    required super.category,
    required super.title,
    required super.amount,
    required super.createdAt,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      category: json['category'] ?? '',
      title: json['title'] ?? '',
      amount: json['amount'] ?? 0,
      createdAt: json['create_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['category'] = category;
    data['title'] = title;
    data['amount'] = amount;
    data['created_at'] = createdAt;
    return data;
  }
}
