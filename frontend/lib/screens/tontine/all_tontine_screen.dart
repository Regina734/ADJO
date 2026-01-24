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
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF3A3A2A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFDB834), width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: TextField(
                controller: searchController,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                decoration: InputDecoration(
                  hintText: 'search by name...',
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 11),
                  border: InputBorder.none,
                  icon: const Icon(
                    Icons.search,
                    color: Color(0xFFFDB834),
                    size: 18,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),
          TabBar(
            controller: _tabController,
            indicatorColor: const Color(0xFFFDB834),
            indicatorWeight: 3,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,
            labelStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(fontSize: 10),
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Active'),
              Tab(text: 'Late'),
              Tab(text: 'My invitations'),
            ],
          ),
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1A1A1A),
        selectedItemColor: const Color(0xFFFDB834),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          const BottomNavigationBarItem(icon: Icon(Icons.people), label: ''),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFFDB834),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.black, size: 20),
            ),
            label: 'Tontine',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.history), label: ''),
          const BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
        onTap: (index) {},
      ),
    );
  }

  Widget _buildTontinesList(String filter) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _buildTontineCard(
            icon: Icons.groups,
            title: 'Circle of entrepreneurs',
            amount: '5000 XOF/month',
            members: '12/15',
            hasJoined: false,
          ),
          const SizedBox(height: 10),
          _buildTontineCard(
            icon: Icons.directions_bike,
            title: 'Coopérative Karité Zem',
            amount: '2500 XOF/Week',
            members: '10/10',
            hasJoined: false,
          ),
          const SizedBox(height: 10),
          _buildTontineCard(
            icon: Icons.shopping_bag,
            title: 'Merchants de Treichville',
            amount: '5000 XOF/month',
            members: '5/10',
            hasJoined: false,
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF3A3A2A),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[800]!, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle, color: Colors.grey[600], size: 18),
                const SizedBox(width: 8),
                Text(
                  'Create my own tontine',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
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
    required bool hasJoined,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A2A),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[800]!, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFDB834).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFFFDB834), size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  amount,
                  style: TextStyle(color: Colors.grey[600], fontSize: 10),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                members,
                style: const TextStyle(
                  color: Color(0xFFFDB834),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: 50,
                height: 28,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/choose-members'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFDB834),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Join',
                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
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
