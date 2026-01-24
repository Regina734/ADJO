import 'package:flutter/material.dart';

class StakingValidateScreen extends StatefulWidget {
  const StakingValidateScreen({Key? key}) : super(key: key);

  @override
  State<StakingValidateScreen> createState() => _StakingValidateScreenState();
}

class _StakingValidateScreenState extends State<StakingValidateScreen> {
  @override
  Widget build(BuildContext context) {
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
          'BOX staking validate',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            // Success Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFFFDB834),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFDB834).withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(Icons.check, color: Colors.black, size: 60),
              ),
            ),
            const SizedBox(height: 24),

            // Title
            const Text(
              'Staking successfully blocked !',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Subtitle
            Text(
              'Your staking transaction has been validated on the blockchain.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
            ),
            const SizedBox(height: 48),

            // Details Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[800]!, width: 1),
              ),
              child: Column(
                children: [
                  // Blocked Amount
                  _buildDetailRow(
                    label: 'Blocked amount',
                    value: '50,000 XOF',
                    valueColor: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Color(0xFF2A2A2A), height: 1),
                  const SizedBox(height: 16),

                  // Frequency
                  _buildDetailRow(
                    label: 'Frequency',
                    value: '6 Monthly',
                    valueColor: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Color(0xFF2A2A2A), height: 1),
                  const SizedBox(height: 16),

                  // Earnings Estimate
                  _buildDetailRow(
                    label: 'Earnings estimate',
                    value: '+1,250 XOF',
                    valueColor: const Color(0xFF00FF00),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Color(0xFF2A2A2A), height: 1),
                  const SizedBox(height: 16),

                  // Unlock Date
                  _buildDetailRow(
                    label: 'Unlock date',
                    value: '14 Otorber 2024',
                    valueColor: const Color(0xFFFDB834),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Certificate Section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[800]!, width: 1),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.verified,
                    color: Color(0xFFFDB834),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: const Text(
                      'CERTIFICATE BLOCKCHAIN',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),

            // Back Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/my-box',
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFDB834),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Back to my Box',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Share Certificate Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFFDB834), width: 1),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.share, color: Color(0xFFFDB834), size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Share my certificate',
                      style: TextStyle(
                        color: Color(0xFFFDB834),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
