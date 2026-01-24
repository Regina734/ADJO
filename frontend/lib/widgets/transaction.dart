import 'package:adjo/models/transaction.dart';
import 'package:adjo/theme/app_theme.dart' show AppTheme;
import 'package:flutter/material.dart';

import '../utils/formatters.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback? onTap;

  const TransactionCard({Key? key, required this.transaction, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = _getIcon();
    final color = _getColor();
    final sign = transaction.isIncome ? '+' : '';

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),

            SizedBox(width: 12),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.description,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    Formatters.formatDate(transaction.date),
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),

            // Amount
            Text(
              '$sign${Formatters.formatCurrency(transaction.amount)}',
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon() {
    switch (transaction.type) {
      case 'deposit':
        return Icons.arrow_downward;
      case 'withdrawal':
        return Icons.arrow_upward;
      case 'staking_reward':
        return Icons.stars;
      case 'tontine_contribution':
        return Icons.people;
      default:
        return Icons.swap_horiz;
    }
  }

  Color _getColor() {
    if (transaction.isIncome) return AppTheme.success;
    if (transaction.type == 'withdrawal') return AppTheme.error;
    return AppTheme.warning;
  }
}
