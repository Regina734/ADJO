import 'package:flutter/material.dart';

class MyCommunityScreen extends StatefulWidget {
  const MyCommunityScreen({Key? key}) : super(key: key);

  @override
  State<MyCommunityScreen> createState() => _MyCommunityScreenState();
}

class _MyCommunityScreenState extends State<MyCommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: const SizedBox(),
        title: const Text(
          'My Community',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Invite Text
            const Text(
              '+ Invite other people to contribute to my memberships fee.',
              style: TextStyle(color: Colors.grey, fontSize: 12, height: 1.5),
            ),
            const SizedBox(height: 20),

            // Create Community Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/create-community-new');
                },
                icon: const Icon(Icons.add, color: Colors.black, size: 20),
                label: const Text(
                  'Create my own community',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFDB834),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Total Collected & Active Aids Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A3A2A),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFFDB834),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Collected',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          '1 450 000',
                          style: TextStyle(
                            color: Color(0xFFFDB834),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'XOF',
                          style: TextStyle(
                            color: Color(0xFFFDB834),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A3A2A),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[800]!, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Active Aids',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          '03',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
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

            // IN COURS Card
            _buildCommunityCard(
              status: 'IN COURS',
              statusColor: const Color(0xFFFDB834),
              days: '12 Days remaining',
              title: 'Medical expenses - Kandi family',
              rule: 'Rule: Voluntary contribution',
              progress: 750000 / 1500000,
              currentAmount: '750 000',
              targetAmount: '1 500 000',
              donorCount: '15 Donors',
              showEvidence: true,
              onContribution: () {},
              onEvidence: () {},
            ),
            const SizedBox(height: 12),

            // SUCCESS Card
            _buildCommunityCard(
              status: 'SUCCESS',
              statusColor: const Color(0xFF00FF00),
              days: 'FINISHED 12 Oct.',
              title: 'Medical expenses - Kandi family',
              rule: 'Rule: Voluntary contribution',
              progress: 750000 / 1500000,
              currentAmount: '750 000',
              targetAmount: '1 500 000',
              donorCount: '45 Donors',
              showEvidence: true,
              onContribution: () {},
              onEvidence: () {},
            ),
            const SizedBox(height: 12),

            // FINISHED Card
            _buildCommunityCard(
              status: 'FINISHED',
              statusColor: Colors.grey,
              days: 'Deadline passed',
              title: 'Medical expenses - Kandi family',
              rule: 'Rule: 5000/ members',
              progress: 0.5,
              currentAmount: '750 000',
              targetAmount: '1 500 000',
              donorCount: '15 Donors',
              showEvidence: false,
              onContribution: () {},
              onEvidence: () {},
              isRelaunch: true,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1A1A1A),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFDB834),
        unselectedItemColor: Colors.grey[600],
        elevation: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: ''),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFFDB834),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.group, color: Colors.black, size: 18),
            ),
            label: '',
          ),
        ],
        onTap: (index) {},
      ),
    );
  }

  Widget _buildCommunityCard({
    required String status,
    required Color statusColor,
    required String days,
    required String title,
    required String rule,
    required double progress,
    required String currentAmount,
    required String targetAmount,
    required String donorCount,
    required bool showEvidence,
    required VoidCallback onContribution,
    required VoidCallback onEvidence,
    bool isRelaunch = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A1A),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[800]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Status and Days
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.access_time, size: 12, color: statusColor),
                  const SizedBox(width: 3),
                  Text(
                    days,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Title
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),

          // Rule
          Text(rule, style: TextStyle(color: Colors.grey[500], fontSize: 10)),
          const SizedBox(height: 8),

          // Progress Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Progress',
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
              Text(
                '$currentAmount / $targetAmount XOF',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 4,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
            ),
          ),
          const SizedBox(height: 8),

          // Donor Avatars
          Row(
            children: [
              ...[1, 2, 3, 4].map(
                (i) => Padding(
                  padding: EdgeInsets.only(right: i == 1 ? 0 : -6),
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.grey[700],
                    child: Text(
                      '$i',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 7,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                donorCount,
                style: TextStyle(color: Colors.grey[500], fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Action Buttons
          if (!isRelaunch)
            Row(
              children: [
                if (showEvidence)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onEvidence,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFFFDB834),
                          width: 1,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        'SEE THE EVIDENCE',
                        style: TextStyle(
                          color: Color(0xFFFDB834),
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                if (showEvidence) const SizedBox(width: 6),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onContribution,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFDB834),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'CONTRIBUTION',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFDB834),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'RELAUNCH',
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
