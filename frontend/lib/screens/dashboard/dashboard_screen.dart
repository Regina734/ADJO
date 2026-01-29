import 'package:adjo/screens/community/my_community_screen.dart';
import 'package:adjo/screens/dashboard/home_screen.dart';
import 'package:adjo/screens/my_box/my_box_screen.dart';
import 'package:adjo/screens/settings/settings_screen.dart';
import 'package:adjo/screens/tontine/my_tontine_screen.dart';
import 'package:adjo/widgets/navbar.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final int initialIndex;

  const DashboardScreen({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late int _currentIndex;

  // List of all screens
  late final List<Widget> _screens = [
    const HomeScreen(),
    const MyCommunityScreen(),
    const MyBoxScreen(),
    const MyTontineScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onAddPressed() {
    // Handle the center FAB button press
    _showAddMenu();
  }

  void _showAddMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'What would you like to do?',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 24),
            // Option 1: Create Tontine
            _buildMenuOption(
              icon: Icons.savings_outlined,
              title: 'Create Tontine',
              subtitle: 'Start a new group savings plan',
              onTap: () {
                Navigator.pop(context);
                _navigateToTontineCreation();
              },
            ),
            const SizedBox(height: 12),
            // Option 2: Create Community
            _buildMenuOption(
              icon: Icons.group_add_outlined,
              title: 'Create Community',
              subtitle: 'Start a new DAO community',
              onTap: () {
                Navigator.pop(context);
                _navigateToCommunityCreation();
              },
            ),
            const SizedBox(height: 12),
            // Option 3: Send Funds
            _buildMenuOption(
              icon: Icons.send_outlined,
              title: 'Send Funds',
              subtitle: 'Transfer money to someone',
              onTap: () {
                Navigator.pop(context);
                _navigateToSendFunds();
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: const Color(0xFF262626),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDB834).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
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
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToTontineCreation() {
    // Navigate to create tontine screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigating to create tontine...')),
    );
  }

  void _navigateToCommunityCreation() {
    // Navigate to create community screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigating to create community...')),
    );
  }

  void _navigateToSendFunds() {
    // Navigate to send funds screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigating to send funds...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent exiting the app from dashboard
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _screens[_currentIndex],
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onNavBarTap,
          onAddPressed: _onAddPressed,
        ),
      ),
    );
  }
}
