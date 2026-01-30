import 'package:adjo/screens/tontine/Join_tontine_conditio.dart';
import 'package:adjo/screens/tontine/details_tontine.dart';

import 'package:flutter/material.dart';

class AllTontineScreen extends StatefulWidget {
  const AllTontineScreen({Key? key}) : super(key: key);

  @override
  State<AllTontineScreen> createState() => _AllTontineScreenState();
}

class _AllTontineScreenState extends State<AllTontineScreen>
    with TickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

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
          'All Tontine',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF8B7355),
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: searchController,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'search by name...',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  icon: const Icon(Icons.search, color: Colors.white, size: 22),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),

          // Tabs
          TabBar(
            controller: _tabController,
            indicatorColor: const Color(0xFFFDB834),
            indicatorWeight: 3,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Active'),
              Tab(text: 'Late'),
              Tab(text: 'My invitations'),
            ],
          ),

          // Divider line
          Container(height: 1, color: Colors.grey[800]),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTontinesList('all'),
                _buildTontinesList('active'),
                _buildTontinesList('late'),
                _buildTontinesList('invitations'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTontinesList(String filter) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildTontineCard(
            icon: Icons.groups,
            title: 'Circle of entrepreneurs',
            amount: '5000 XOF/month',
            members: '12/15',
          ),
          const SizedBox(height: 12),
          _buildTontineCard(
            icon: Icons.directions_bike,
            title: 'Coopérative Karité Zem',
            amount: '2500 XOF/Week',
            members: '10/10',
          ),
          const SizedBox(height: 12),
          _buildTontineCard(
            icon: Icons.shopping_bag,
            title: 'Marchands de Treichville',
            amount: '5000 XOF/month',
            members: '5/10',
          ),
        ],
      ),
    );
  }

  Widget _buildTontineCard({
    required IconData icon,
    required String title,
    required String amount,
    required String members,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF8B7355), width: 1.5),
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF8B7355),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFDB834), width: 2),
            ),
            child: Icon(icon, color: const Color(0xFFFDB834), size: 30),
          ),
          const SizedBox(width: 12),

          // Title and amount
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
                const SizedBox(height: 4),
                Text(
                  amount,
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
                const SizedBox(height: 8),

                // See details button - NAVIGATE TO DETAILS PAGE
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TontineDetailsScreen(
                          tontineName: title,
                          amount: amount,
                          frequency: amount.contains('Week')
                              ? 'Weekly'
                              : 'Monthly',
                          members: members,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B7355),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'See details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Members count and Join button
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                members,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Join button - Navigate to conditions
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TontineConditionsScreen(
                        tontineName: title,
                        amount: amount,
                        frequency: amount.contains('Week')
                            ? 'Weekly'
                            : 'Monthly',
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDB834),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Join',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
