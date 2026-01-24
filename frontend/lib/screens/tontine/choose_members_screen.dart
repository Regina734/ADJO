import 'package:flutter/material.dart';

class ChooseMembersScreen extends StatefulWidget {
  const ChooseMembersScreen({Key? key}) : super(key: key);

  @override
  State<ChooseMembersScreen> createState() => _ChooseMembersScreenState();
}

class _ChooseMembersScreenState extends State<ChooseMembersScreen>
    with TickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();
  late TabController _tabController;
  final List<Map<String, dynamic>> allMembers = [
    {
      'name': 'John Doe',
      'reliability': 100,
      'status': 'Trusted Member',
      'since': 2022,
      'selected': false,
      'category': 'all',
    },
    {
      'name': 'Jane Smith',
      'reliability': 75,
      'status': 'Trusted Member',
      'since': 2020,
      'selected': false,
      'category': 'favorite',
    },
    {
      'name': 'Bob Wilson',
      'reliability': 80,
      'status': 'New Member',
      'since': 2024,
      'selected': false,
      'category': 'new',
    },
    {
      'name': 'Alice Brown',
      'reliability': 100,
      'status': 'Trusted Member',
      'since': 2022,
      'selected': false,
      'category': 'all',
    },
  ];

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
          'Choose your members',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Container(
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
            const SizedBox(height: 12),
            TabBar(
              controller: _tabController,
              indicatorColor: const Color(0xFFFDB834),
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'Favorite'),
                Tab(text: 'New'),
                Tab(text: 'Ancient'),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 250,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildMembersListForCategory('all'),
                  _buildMembersListForCategory('favorite'),
                  _buildMembersListForCategory('new'),
                  _buildMembersListForCategory('ancient'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF3A3A2A),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[800]!, width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${allMembers.where((m) => m['selected']).length} Members validated',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'All unchecked',
                          style: TextStyle(color: Colors.grey, fontSize: 9),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/caution-details');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFDB834),
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Validate the members',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildMembersListForCategory(String category) {
    final filteredMembers = category == 'all'
        ? allMembers
        : allMembers.where((m) => m['category'] == category).toList();

    if (filteredMembers.isEmpty) {
      return const Center(
        child: Text(
          'No members in this category',
          style: TextStyle(color: Colors.grey, fontSize: 11),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredMembers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final member = filteredMembers[index];
        final isSelected = member['selected'] as bool;
        final reliabilityValue = member['reliability'] as int;
        final reliabilityColor = reliabilityValue == 100
            ? Colors.amber
            : Colors.grey;

        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF3A3A2A),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? const Color(0xFFFDB834) : Colors.grey[800]!,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color(0xFFFDB834),
                    child: const Text(
                      'ID',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reliability: ${reliabilityValue}%',
                          style: TextStyle(
                            color: reliabilityColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          member['status'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Member since ${member['since']}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFFDB834)
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFDB834),
                        width: 2,
                      ),
                    ),
                    child: Checkbox(
                      value: isSelected,
                      onChanged: (value) {
                        setState(() {
                          member['selected'] = value ?? false;
                        });
                      },
                      fillColor: MaterialStateProperty.all(
                        isSelected
                            ? const Color(0xFFFDB834)
                            : Colors.transparent,
                      ),
                      checkColor: Colors.black,
                      side: BorderSide.none,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
