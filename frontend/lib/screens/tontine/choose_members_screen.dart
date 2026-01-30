import 'package:adjo/screens/tontine/detail_members_screen.dart';
import 'package:flutter/material.dart';
//import 'detail_members_screen.dart';

class ChooseMembersScreen extends StatefulWidget {
  final int maxMembers;

  const ChooseMembersScreen({Key? key, required this.maxMembers})
    : super(key: key);

  @override
  State<ChooseMembersScreen> createState() => _ChooseMembersScreenState();
}

class _ChooseMembersScreenState extends State<ChooseMembersScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();
  final List<Map<String, dynamic>> selectedParticipants = [];
  late TabController _tabController;

  // Mock contacts list with reliability and status
  final List<Map<String, dynamic>> allContacts = [
    {
      'name': 'Karim Diallo',
      'phone': '+229 61 76 25 91',
      'avatar': 'K',
      'reliability': 100,
      'status': 'Trusted Member',
      'since': 2022,
      'category': 'all',
      'isFavorite': true,
    },
    {
      'name': 'Amina Kouassi',
      'phone': '+229 97 45 32 18',
      'avatar': 'A',
      'reliability': 75,
      'status': 'Trusted Member',
      'since': 2020,
      'category': 'all',
      'isFavorite': true,
    },
    {
      'name': 'Ibrahim Touré',
      'phone': '+229 66 89 12 45',
      'avatar': 'I',
      'reliability': 80,
      'status': 'New Member',
      'since': 2024,
      'category': 'new',
      'isFavorite': false,
    },
    {
      'name': 'Fatou Sow',
      'phone': '+229 91 23 56 78',
      'avatar': 'F',
      'reliability': 100,
      'status': 'Trusted Member',
      'since': 2022,
      'category': 'all',
      'isFavorite': false,
    },
    {
      'name': 'Moussa Bah',
      'phone': '+229 67 34 89 01',
      'avatar': 'M',
      'reliability': 90,
      'status': 'Trusted Member',
      'since': 2021,
      'category': 'ancient',
      'isFavorite': true,
    },
    {
      'name': 'Aïcha Diop',
      'phone': '+229 96 12 45 67',
      'avatar': 'A',
      'reliability': 85,
      'status': 'Ancient Member',
      'since': 2019,
      'category': 'ancient',
      'isFavorite': false,
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
          onPressed: () => Navigator.pop(context, selectedParticipants),
        ),
        title: const Text(
          'Choose your members',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
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
                onChanged: (value) => setState(() {}),
              ),
            ),
          ),

          // Tabs
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
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
                Tab(text: 'All'),
                Tab(text: 'Favorite'),
                Tab(text: 'New'),
                Tab(text: 'Ancient'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Members list
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMembersList('all'),
                _buildMembersList('favorite'),
                _buildMembersList('new'),
                _buildMembersList('ancient'),
              ],
            ),
          ),

          // Bottom info and button
          Container(
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Members count
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${selectedParticipants.length} Members validated',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              selectedParticipants.length == allContacts.length
                                  ? 'All checked'
                                  : 'All unchecked',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        if (selectedParticipants.isNotEmpty)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                selectedParticipants.clear();
                              });
                            },
                            child: const Text(
                              'Clear all',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Validate button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: selectedParticipants.isEmpty
                          ? null
                          : () => Navigator.pop(context, selectedParticipants),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedParticipants.isEmpty
                            ? Colors.grey[700]
                            : const Color(0xFFFDB834),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Validate the members',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersList(String category) {
    List<Map<String, dynamic>> filteredContacts;

    if (category == 'all') {
      filteredContacts = allContacts;
    } else if (category == 'favorite') {
      filteredContacts = allContacts.where((c) => c['isFavorite']).toList();
    } else {
      filteredContacts = allContacts
          .where((c) => c['category'] == category)
          .toList();
    }

    // Apply search filter
    if (searchController.text.isNotEmpty) {
      filteredContacts = filteredContacts
          .where(
            (contact) =>
                contact['name'].toLowerCase().contains(
                  searchController.text.toLowerCase(),
                ) ||
                contact['phone'].contains(searchController.text),
          )
          .toList();
    }

    if (filteredContacts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 64, color: Colors.grey[600]),
            const SizedBox(height: 16),
            Text(
              'No members in this category',
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filteredContacts.length,
      itemBuilder: (context, index) {
        final contact = filteredContacts[index];
        final isSelected = selectedParticipants.any(
          (p) => p['phone'] == contact['phone'],
        );
        final canSelect =
            selectedParticipants.length < widget.maxMembers || isSelected;

        return _buildMemberCard(contact, isSelected, canSelect);
      },
    );
  }

  Widget _buildMemberCard(
    Map<String, dynamic> contact,
    bool isSelected,
    bool canSelect,
  ) {
    final reliability = contact['reliability'] as int;
    final isHighReliability = reliability == 100;

    return GestureDetector(
      onTap: () {
        // Navigate to detail members screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailMembersScreen(memberData: contact),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF3D3D2D),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFDB834)
                : const Color(0xFF5A5A4A),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Badge for high reliability
            if (isHighReliability)
              Positioned(
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDB834),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.verified,
                    color: Colors.black,
                    size: 16,
                  ),
                ),
              ),
            if (isHighReliability) const SizedBox(width: 8),

            // Avatar
            CircleAvatar(
              radius: 24,
              backgroundColor: const Color(0xFFFDB834),
              child: const Text(
                'ID',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Member info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Reliability: $reliability%',
                        style: TextStyle(
                          color: isHighReliability
                              ? const Color(0xFFFDB834)
                              : Colors.grey[400],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    contact['status'],
                    style: TextStyle(
                      color: isHighReliability ? Colors.green : Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Member since ${contact['since']}',
                    style: TextStyle(color: Colors.grey[500], fontSize: 11),
                  ),
                ],
              ),
            ),

            // Checkbox
            GestureDetector(
              onTap: canSelect
                  ? () {
                      setState(() {
                        if (isSelected) {
                          selectedParticipants.removeWhere(
                            (p) => p['phone'] == contact['phone'],
                          );
                        } else {
                          if (selectedParticipants.length < widget.maxMembers) {
                            selectedParticipants.add(contact);
                          }
                        }
                      });
                    }
                  : null,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFFDB834)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFFDB834), width: 2),
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.black, size: 20)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
