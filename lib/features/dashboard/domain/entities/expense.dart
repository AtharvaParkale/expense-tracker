class Expense {
  final String id;
  final String userId;
  final String category;
  final String title;
  final double amount;
  final String createdAt;

  Expense({
    required this.id,
    required this.userId,
    required this.category,
    required this.title,
    required this.amount,
    required this.createdAt,
  });
}
