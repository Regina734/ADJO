import 'package:adjo/screens/tontine/Join_tontine_conditio.dart';
import 'package:flutter/material.dart';

class TontineDetailsScreen extends StatefulWidget {
  final String tontineName;
  final String amount;
  final String frequency;
  final String members;

  const TontineDetailsScreen({
    Key? key,
    required this.tontineName,
    required this.amount,
    required this.frequency,
    required this.members,
  }) : super(key: key);

  @override
  State<TontineDetailsScreen> createState() => _TontineDetailsScreenState();
}

class _TontineDetailsScreenState extends State<TontineDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Parse contribution amount
    final contributionAmount = double.parse(
      widget.amount.replaceAll(RegExp(r'[^0-9.]'), ''),
    );
    final depositAmount = contributionAmount * 0.20;
    final totalAmount = contributionAmount + depositAmount;

    // Parse members
    final membersParts = widget.members.split('/');
    final currentMembers = int.parse(membersParts[0]);
    final maxMembers = int.parse(membersParts[1]);
    final progress = currentMembers / maxMembers;

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
          'Tontine Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () => _shareTontine(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tontine header card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFFDB834), width: 1.5),
            ),
            child: Column(
              children: [
                Text(
                  widget.tontineName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildInfoChip(Icons.calendar_today, widget.frequency),
                    const SizedBox(width: 12),
                    _buildInfoChip(Icons.people, widget.members),
                  ],
                ),
                const SizedBox(height: 16),
                // Progress bar
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Members',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '${(progress * 100).toInt()}% Full',
                          style: const TextStyle(
                            color: Color(0xFFFDB834),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        backgroundColor: Colors.grey[800],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFFFDB834),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Amount info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildAmountInfo(
                      'Contribution',
                      '${contributionAmount.toStringAsFixed(0)} XOF',
                      false,
                    ),
                    Container(width: 1, height: 40, color: Colors.grey[800]),
                    _buildAmountInfo(
                      'Deposit (20%)',
                      '${depositAmount.toStringAsFixed(0)} XOF',
                      true,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tabs
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: const Color(0xFFFDB834),
              indicatorWeight: 3,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.white,
              labelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Members'),
                Tab(text: 'Rules'),
              ],
            ),
          ),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(contributionAmount, maxMembers),
                _buildMembersTab(),
                _buildRulesTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () => _joinTontine(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFDB834),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Join - ${totalAmount.toStringAsFixed(0)} XOF',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFFFDB834), size: 14),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountInfo(String label, String value, bool highlight) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 11)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: highlight ? const Color(0xFFFDB834) : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewTab(double contribution, int maxMembers) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About this Tontine',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'This is a ${widget.frequency.toLowerCase()} rotating savings group where members contribute regularly and take turns receiving the collected funds.',
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),

          // Key details cards
          _buildDetailCard(
            icon: Icons.account_balance_wallet,
            title: 'Total per Cycle',
            value: '${(contribution * maxMembers).toStringAsFixed(0)} XOF',
            description:
                'Each member receives this amount when it\'s their turn',
          ),
          const SizedBox(height: 12),
          _buildDetailCard(
            icon: Icons.calendar_month,
            title: 'Frequency',
            value: widget.frequency,
            description: 'How often contributions are due',
          ),
          const SizedBox(height: 12),
          _buildDetailCard(
            icon: Icons.lock_outline,
            title: 'Security Deposit',
            value: '20% Required',
            description: 'Refundable at the end of the cycle',
          ),
          const SizedBox(height: 12),
          _buildDetailCard(
            icon: Icons.verified_outlined,
            title: 'Blockchain Secured',
            value: 'Stellar Network',
            description: 'All transactions are transparent and secure',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required String value,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFDB834).withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFFFDB834), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey[500], fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersTab() {
    final members = [
      {
        'name': 'Karim Diallo',
        'status': 'Active',
        'position': 'Round 1',
        'paid': true,
      },
      {
        'name': 'Amina Kouassi',
        'status': 'Active',
        'position': 'Round 2',
        'paid': true,
      },
      {
        'name': 'Ibrahim Touré',
        'status': 'Active',
        'position': 'Round 3',
        'paid': false,
      },
      {
        'name': 'Fatou Sow',
        'status': 'Pending',
        'position': 'Round 4',
        'paid': false,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: members.length,
      itemBuilder: (context, index) {
        final member = members[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: member['paid'] as bool
                  ? const Color(0xFFFDB834)
                  : Colors.grey[800]!,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: const Color(0xFFFDB834),
                child: Text(
                  member['name'].toString()[0],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member['name'].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      member['position'].toString(),
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: (member['paid'] as bool ? Colors.green : Colors.orange)
                      .withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  member['paid'] as bool ? 'Paid' : 'Pending',
                  style: TextStyle(
                    color: member['paid'] as bool
                        ? Colors.green
                        : Colors.orange,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRulesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tontine Rules',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          _buildRuleCard(
            '1',
            'Regular Contributions',
            'All members must contribute on time according to the ${widget.frequency.toLowerCase()} schedule.',
          ),
          const SizedBox(height: 12),
          _buildRuleCard(
            '2',
            'Security Deposit',
            'A 20% deposit is required to join. This will be fully refunded at the end of the cycle.',
          ),
          const SizedBox(height: 12),
          _buildRuleCard(
            '3',
            'Receiving Order',
            'Members receive funds in a predetermined rotating order. You cannot skip your turn.',
          ),
          const SizedBox(height: 12),
          _buildRuleCard(
            '4',
            'Late Payments',
            'Late payments may result in penalties. Repeated late payments can lead to exclusion.',
          ),
          const SizedBox(height: 12),
          _buildRuleCard(
            '5',
            'Early Exit',
            'Leaving before the cycle ends may result in forfeiting your security deposit.',
          ),
          const SizedBox(height: 12),
          _buildRuleCard(
            '6',
            'Transparency',
            'All transactions are recorded on the blockchain for complete transparency.',
          ),
        ],
      ),
    );
  }

  Widget _buildRuleCard(String number, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFFFDB834),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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

  void _shareTontine() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Color(0xFF2A2A2A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.share, color: Color(0xFFFDB834), size: 48),
            const SizedBox(height: 16),
            Text(
              'Share ${widget.tontineName}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildShareOption(Icons.link, 'Copy Link'),
                _buildShareOption(Icons.qr_code, 'QR Code'),
                _buildShareOption(Icons.message, 'Message'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$label - Coming soon!')));
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFFFDB834), size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 12)),
        ],
      ),
    );
  }

  void _joinTontine() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TontineConditionsScreen(
          tontineName: widget.tontineName,
          amount: widget.amount,
          frequency: widget.frequency,
        ),
      ),
    );
  }
}
