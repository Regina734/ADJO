import 'package:adjo/screens/my_box/staking_screen.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyBoxScreen extends StatefulWidget {
  const MyBoxScreen({Key? key}) : super(key: key);

  @override
  State<MyBoxScreen> createState() => _MyBoxScreenState();
}

class _MyBoxScreenState extends State<MyBoxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'My Box',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.access_time, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // QR Code and Public Identifier Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF3A3A2A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // QR Code
                  Container(
                    width: 70,
                    height: 70,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomPaint(painter: QRCodePainter()),
                  ),
                  const SizedBox(width: 16),
                  // Address Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PUBLIC IDENTIFIER',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              'GAB...XYZ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.copy,
                              size: 16,
                              color: Color(0xFFFDB834),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Balance Section
            Row(
              children: [
                // Total Balance
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.visibility_outlined,
                              size: 16,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'TOTAL BALANCE',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          '000,000 XOF',
                          style: TextStyle(
                            color: Color(0xFFFDB834),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Blocked Balance
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.lock_outline,
                              size: 16,
                              color: Color(0xFFFDB834),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Blocked',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          '00,000 XOF',
                          style: TextStyle(
                            color: Color(0xFFFDB834),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                _buildActionButton(
                  icon: Icons.arrow_downward,
                  label: 'Deposit',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Scaffold()),
                    );
                  },
                ),
                const SizedBox(width: 12),
                _buildActionButton(
                  icon: Icons.arrow_upward,
                  label: 'Remove',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Scaffold()),
                    );
                  },
                ),
                const SizedBox(width: 12),
                _buildActionButton(
                  icon: Icons.layers,
                  label: 'Staking',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StakingSetupScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Performance Chart
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF3A3A2A), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Performance',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            '+11500 XOF',
                            style: TextStyle(
                              color: Color(0xFF00FF00),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF00FF00).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.arrow_upward,
                                  size: 10,
                                  color: Color(0xFF00FF00),
                                ),
                                SizedBox(width: 2),
                                Text(
                                  '12.6%',
                                  style: TextStyle(
                                    color: Color(0xFF00FF00),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Lifetime earnings (+30)',
                    style: TextStyle(color: Colors.grey[600], fontSize: 10),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 120,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        minX: 0,
                        maxX: 11,
                        minY: 0,
                        maxY: 40,
                        lineBarsData: [
                          LineChartBarData(
                            spots: const [
                              FlSpot(0, 10),
                              FlSpot(1, 12),
                              FlSpot(2, 8),
                              FlSpot(3, 15),
                              FlSpot(4, 18),
                              FlSpot(5, 14),
                              FlSpot(6, 20),
                              FlSpot(7, 22),
                              FlSpot(8, 25),
                              FlSpot(9, 24),
                              FlSpot(10, 28),
                              FlSpot(11, 30),
                            ],
                            isCurved: true,
                            color: const Color(0xFF00FF00),
                            barWidth: 2,
                            isStrokeCapRound: true,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF00FF00).withOpacity(0.3),
                                  const Color(0xFF00FF00).withOpacity(0.0),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ],
                        lineTouchData: LineTouchData(enabled: false),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Recent Activity Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Activity',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: Navigate to full history
                  },
                  child: const Text(
                    'View History',
                    style: TextStyle(
                      color: Color(0xFFFDB834),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Activity List
            _buildActivityItem(
              icon: Icons.check_circle,
              iconBgColor: const Color(0xFF00FF00).withOpacity(0.2),
              iconColor: const Color(0xFF00FF00),
              title: 'Staking Rewards',
              subtitle: '12 Oct 2023 - 14:20',
              amount: '+240 XOF',
              amountColor: const Color(0xFF00FF00),
            ),
            const SizedBox(height: 12),
            _buildActivityItem(
              icon: Icons.arrow_upward,
              iconBgColor: Colors.red.withOpacity(0.2),
              iconColor: Colors.red,
              title: 'Outgoing transfer',
              subtitle: '12 Oct 2023 - 14:20',
              amount: '-5.000 XOF',
              amountColor: Colors.red,
            ),
            const SizedBox(height: 12),
            _buildActivityItem(
              icon: Icons.account_balance_wallet,
              iconBgColor: const Color(0xFFFDB834).withOpacity(0.2),
              iconColor: const Color(0xFFFDB834),
              title: 'Bank deposit',
              subtitle: '12 Oct 2023 - 14:20',
              amount: '+00,000 XOF',
              amountColor: const Color(0xFF00FF00),
            ),
            const SizedBox(height: 80), // Space for navbar
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFFDB834),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Icon(icon, color: Colors.black, size: 20),
              const SizedBox(height: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String amount,
    required Color amountColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Icon(icon, color: iconColor, size: 20)),
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
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600], fontSize: 11),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  color: amountColor,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'View Hash',
                style: TextStyle(color: Colors.grey[600], fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Custom QR Code Painter
class QRCodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final cellSize = size.width / 8;

    // Simple QR code pattern
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if ((i + j) % 2 == 0) {
          canvas.drawRect(
            Rect.fromLTWH(i * cellSize, j * cellSize, cellSize, cellSize),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
