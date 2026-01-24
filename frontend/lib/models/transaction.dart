import 'package:adjo/models/tontine.dart';

class Transaction {
  final String id;
  final String
  type; // 'deposit', 'withdrawal', 'staking_reward', 'tontine_contribution'
  final double amount;
  final DateTime date;
  final String status; // 'pending', 'completed', 'failed'
  final String description;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    required this.status,
    required this.description,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json['id'],
    type: json['type'],
    amount: json['amount'].toDouble(),
    date: DateTime.parse(json['date']),
    status: json['status'],
    description: json['description'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'amount': amount,
    'date': date.toIso8601String(),
    'status': status,
    'description': description,
  };
}

extension TransactionTypeExtension on Transaction {
  bool get isIncome => type == 'deposit' || type == 'staking_reward';
  bool get isExpense => type == 'withdrawal' || type == 'tontine_contribution';

  String get displayAmount {
    final sign = isIncome ? '+' : '';
    return '$sign${amount.toStringAsFixed(0)} XOF';
  }
}

extension TontineStatusExtension on Tontine {
  bool get isActive => status == 'active';
  bool get isPending => status == 'pending';
  bool get isCompleted => status == 'completed';

  double get totalAmount => amount * maxMembers;
  int get remainingSlots => maxMembers - currentMembers;
}
