import 'package:flutter/material.dart';

class TontineConditionsScreen extends StatefulWidget {
  final String tontineName;
  final String amount;
  final String frequency;

  const TontineConditionsScreen({
    Key? key,
    required this.tontineName,
    required this.amount,
    required this.frequency,
  }) : super(key: key);

  @override
  State<TontineConditionsScreen> createState() =>
      _TontineConditionsScreenState();
}

class _TontineConditionsScreenState extends State<TontineConditionsScreen> {
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    // Calculate deposit (20% of contribution)
    final contributionAmount = double.parse(
      widget.amount.replaceAll(RegExp(r'[^0-9.]'), ''),
    );
    final depositAmount = contributionAmount * 0.20;
    final totalAmount = contributionAmount + depositAmount;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Join Tontine',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tontine info card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFDB834), width: 1),
              ),
              child: Column(
                children: [
                  Text(
                    widget.tontineName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.grey[400],
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.frequency,
                        style: TextStyle(color: Colors.grey[400], fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Payment breakdown
            const Text(
              'Payment Breakdown',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildPaymentRow(
                    'Regular contribution',
                    '${contributionAmount.toStringAsFixed(0)} XOF',
                    false,
                  ),
                  const SizedBox(height: 16),
                  _buildPaymentRow(
                    'Security deposit (20%)',
                    '${depositAmount.toStringAsFixed(0)} XOF',
                    true,
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 16),
                  _buildPaymentRow(
                    'Total to pay now',
                    '${totalAmount.toStringAsFixed(0)} XOF',
                    false,
                    isBold: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Conditions section
            const Text(
              'Conditions & Terms',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            _buildConditionCard(
              Icons.lock_outline,
              'Security Deposit',
              'A 20% deposit ensures commitment. It will be fully refunded at the end of the cycle if all contributions are completed.',
            ),
            const SizedBox(height: 12),

            _buildConditionCard(
              Icons.calendar_month,
              'Payment Schedule',
              'You must contribute on time according to the ${widget.frequency} schedule. Late payments may result in penalties.',
            ),
            const SizedBox(height: 12),

            _buildConditionCard(
              Icons.group_outlined,
              'Membership Commitment',
              'By joining, you commit to the full cycle. Leaving early may result in forfeiting your deposit.',
            ),
            const SizedBox(height: 12),

            _buildConditionCard(
              Icons.gavel_outlined,
              'Tontine Rules',
              'All members must follow the group rules. Violations may lead to exclusion and deposit forfeiture.',
            ),
            const SizedBox(height: 12),

            _buildConditionCard(
              Icons.verified_user_outlined,
              'Blockchain Security',
              'All transactions are secured on the Stellar blockchain for transparency and safety.',
            ),
            const SizedBox(height: 32),

            // Deposit refund info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFDB834).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFDB834), width: 1),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xFFFDB834),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Your ${depositAmount.toStringAsFixed(0)} XOF deposit will be returned to you at the end of the cycle if you complete all your contributions.',
                      style: const TextStyle(
                        color: Color(0xFFFDB834),
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Agreement checkbox
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreedToTerms = value ?? false;
                      });
                    },
                    activeColor: const Color(0xFFFDB834),
                    checkColor: Colors.black,
                  ),
                  Expanded(
                    child: Text(
                      'I have read and agree to the conditions and terms of this tontine',
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFFFDB834),
                        width: 1.5,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xFFFDB834),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _agreedToTerms
                        ? () => _joinTontine(context, totalAmount)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _agreedToTerms
                          ? const Color(0xFFFDB834)
                          : Colors.grey[700],
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Pay ${totalAmount.toStringAsFixed(0)} XOF & Join',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentRow(
    String label,
    String value,
    bool isDeposit, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 14,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              if (isDeposit) ...[
                const SizedBox(height: 4),
                Text(
                  'Refundable',
                  style: TextStyle(
                    color: const Color(0xFFFDB834),
                    fontSize: 11,
                  ),
                ),
              ],
            ],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isDeposit ? const Color(0xFFFDB834) : Colors.white,
            fontSize: isBold ? 18 : 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildConditionCard(IconData icon, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFDB834).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFFFDB834), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _joinTontine(BuildContext context, double totalAmount) {
    // TODO: Implement payment and join logic
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Confirm Payment',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'You are about to pay ${totalAmount.toStringAsFixed(0)} XOF to join "${widget.tontineName}".',
          style: TextStyle(color: Colors.grey[300]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    '✓ Payment successful! You have joined the tontine.',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFDB834),
              foregroundColor: Colors.black,
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
