import 'package:flutter/material.dart';

class InviteParticipantsScreen extends StatefulWidget {
  final int maxMembers;

  const InviteParticipantsScreen({Key? key, required this.maxMembers})
    : super(key: key);

  @override
  State<InviteParticipantsScreen> createState() =>
      _InviteParticipantsScreenState();
}

class _InviteParticipantsScreenState extends State<InviteParticipantsScreen> {
  final TextEditingController searchController = TextEditingController();
  final List<Map<String, dynamic>> selectedParticipants = [];

  // Mock contacts list
  final List<Map<String, dynamic>> allContacts = [
    {'name': 'Karim Diallo', 'phone': '+229 61 76 25 91', 'avatar': 'K'},
    {'name': 'Amina Kouassi', 'phone': '+229 97 45 32 18', 'avatar': 'A'},
    {'name': 'Ibrahim Touré', 'phone': '+229 66 89 12 45', 'avatar': 'I'},
    {'name': 'Fatou Sow', 'phone': '+229 91 23 56 78', 'avatar': 'F'},
    {'name': 'Moussa Bah', 'phone': '+229 67 34 89 01', 'avatar': 'M'},
    {'name': 'Aïcha Diop', 'phone': '+229 96 12 45 67', 'avatar': 'A'},
    {'name': 'Seydou Traoré', 'phone': '+229 65 78 90 12', 'avatar': 'S'},
    {'name': 'Mariama Cissé', 'phone': '+229 90 45 23 78', 'avatar': 'M'},
  ];

  @override
  void dispose() {
    searchController.dispose();
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
          'Invite Participants',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: selectedParticipants.isEmpty
                ? null
                : () => Navigator.pop(context, selectedParticipants),
            child: Text(
              'Done',
              style: TextStyle(
                color: selectedParticipants.isEmpty
                    ? Colors.grey
                    : const Color(0xFFFDB834),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Selected count banner
          if (selectedParticipants.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              color: const Color(0xFFFDB834).withOpacity(0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${selectedParticipants.length} / ${widget.maxMembers} selected',
                    style: const TextStyle(
                      color: Color(0xFFFDB834),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
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

          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey[800]!),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: searchController,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Search by name or phone...',
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                  border: InputBorder.none,
                  icon: const Icon(Icons.search, color: Colors.grey, size: 22),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onChanged: (value) => setState(() {}),
              ),
            ),
          ),

          // Quick actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildQuickActionButton(
                    icon: Icons.link,
                    label: 'Invite by link',
                    onTap: () => _shareInviteLink(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildQuickActionButton(
                    icon: Icons.qr_code,
                    label: 'QR Code',
                    onTap: () => _showQRCode(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Section header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Contacts',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.sync,
                    color: Color(0xFFFDB834),
                    size: 16,
                  ),
                  label: const Text(
                    'Sync contacts',
                    style: TextStyle(color: Color(0xFFFDB834), fontSize: 12),
                  ),
                ),
              ],
            ),
          ),

          // Contacts list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _getFilteredContacts().length,
              itemBuilder: (context, index) {
                final contact = _getFilteredContacts()[index];
                final isSelected = selectedParticipants.any(
                  (p) => p['phone'] == contact['phone'],
                );
                final canSelect =
                    selectedParticipants.length < widget.maxMembers ||
                    isSelected;

                return _buildContactCard(contact, isSelected, canSelect);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: selectedParticipants.isNotEmpty
          ? Container(
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
                  onPressed: () => Navigator.pop(context, selectedParticipants),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFDB834),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Invite ${selectedParticipants.length} participant${selectedParticipants.length > 1 ? 's' : ''}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  List<Map<String, dynamic>> _getFilteredContacts() {
    if (searchController.text.isEmpty) {
      return allContacts;
    }
    return allContacts
        .where(
          (contact) =>
              contact['name'].toLowerCase().contains(
                searchController.text.toLowerCase(),
              ) ||
              contact['phone'].contains(searchController.text),
        )
        .toList();
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFFDB834)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFFFDB834), size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFFFDB834),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
    Map<String, dynamic> contact,
    bool isSelected,
    bool canSelect,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? const Color(0xFFFDB834) : Colors.grey[800]!,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: const Color(0xFFFDB834),
          child: Text(
            contact['avatar'],
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          contact['name'],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          contact['phone'],
          style: TextStyle(color: Colors.grey[400], fontSize: 12),
        ),
        trailing: Checkbox(
          value: isSelected,
          onChanged: canSelect
              ? (value) {
                  setState(() {
                    if (value == true) {
                      if (selectedParticipants.length < widget.maxMembers) {
                        selectedParticipants.add(contact);
                      }
                    } else {
                      selectedParticipants.removeWhere(
                        (p) => p['phone'] == contact['phone'],
                      );
                    }
                  });
                }
              : null,
          activeColor: const Color(0xFFFDB834),
          checkColor: Colors.black,
        ),
      ),
    );
  }

  void _shareInviteLink() {
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
            const Icon(Icons.link, color: Color(0xFFFDB834), size: 48),
            const SizedBox(height: 16),
            const Text(
              'Share Invitation Link',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Share this link with people you want to invite',
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Text(
                      'https://adjo.app/invite/xyz123',
                      style: TextStyle(color: Color(0xFFFDB834), fontSize: 12),
                    ),
                  ),
                  Icon(Icons.copy, color: Color(0xFFFDB834), size: 20),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Link copied to clipboard!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFDB834),
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Copy & Share',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQRCode() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Scan to Join',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.qr_code_2,
                size: 200,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Let others scan this QR code to join',
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(color: Color(0xFFFDB834)),
            ),
          ),
        ],
      ),
    );
  }
}
