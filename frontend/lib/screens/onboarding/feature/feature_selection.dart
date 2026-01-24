import 'package:flutter/material.dart';

class FeatureSelectionScreen extends StatefulWidget {
  const FeatureSelectionScreen({Key? key}) : super(key: key);

  @override
  State<FeatureSelectionScreen> createState() => _FeatureSelectionScreenState();
}

class _FeatureSelectionScreenState extends State<FeatureSelectionScreen> {
  String? selectedFeature;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFDB834)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'STEP 0 OF 4',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward, color: Color(0xFFFDB834)),
            onPressed: () {
              // Navigation vers step 1
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress bar
            Container(
              height: 3,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: LinearProgressIndicator(
                value: 0.25, // 0/4 = 25%
                backgroundColor: Colors.grey[800],
                valueColor: AlwaysStoppedAnimation(Color(0xFFFDB834)),
              ),
            ),

            SizedBox(height: 30),

            // Titre et description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Text(
                    'Choose your first\nfree feature',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Select a starting point to unlock your\ndecentralized journey. You can unlock\nothers later.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Liste des features
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildFeatureCard(
                    icon: Icons.people,
                    title: 'Join a Community',
                    description:
                        'Connect with your community and save together on the blockchain using smart contracts.',
                    category: 'SOCIAL SAVING',
                    badge: 'MOST POPULAR',
                    isSelected: selectedFeature == 'community',
                    onTap: () {
                      setState(() => selectedFeature = 'community');
                    },
                  ),
                  SizedBox(height: 16),
                  _buildFeatureCard(
                    icon: Icons.people,
                    title: 'Join a Tontine',
                    description:
                        'Connect with your tontine and save together on the blockchain using smart contracts.',
                    category: 'SOCIAL SAVING',
                    badge: 'MOST POPULAR',
                    isSelected: selectedFeature == 'tontine',
                    onTap: () {
                      setState(() => selectedFeature = 'tontine');
                    },
                  ),
                  SizedBox(height: 16),
                  _buildFeatureCard(
                    icon: Icons.account_balance_wallet,
                    title: 'My Box',
                    description:
                        'Manage your personal savings with a secure, decentralized digital wallet.',
                    category: 'SOCIAL SAVING',
                    badge: null,
                    isSelected: selectedFeature == 'mybox',
                    hasInfoIcon: true,
                    onTap: () {
                      setState(() => selectedFeature = 'mybox');
                    },
                  ),
                  SizedBox(height: 16),
                  _buildFeatureCard(
                    icon: Icons.school,
                    title: 'Academy & Demo',
                    description:
                        'Learn the ropes of DeFi and practice with a risk-free demo account before going live',
                    category: 'EDUCATION',
                    badge: null,
                    isSelected: selectedFeature == 'academy',
                    onTap: () {
                      setState(() => selectedFeature = 'academy');
                    },
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required String category,
    String? badge,
    bool hasInfoIcon = false,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3D3420), Color(0xFF2D2418)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: Color(0xFFFDB834), width: 2)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Icon et Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFFDB834).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Color(0xFFFDB834), size: 32),
                ),
                if (badge != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFF5A4A2A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      badge,
                      style: TextStyle(
                        color: Color(0xFFFDB834),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (hasInfoIcon)
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFFDB834), width: 1.5),
                    ),
                    child: Icon(
                      Icons.info_outline,
                      color: Color(0xFFFDB834),
                      size: 16,
                    ),
                  ),
              ],
            ),

            SizedBox(height: 16),

            // Titre
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            // Description
            Text(
              description,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 13,
                height: 1.4,
              ),
            ),

            SizedBox(height: 16),

            // Footer: Catégorie et Bouton
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFF2A2420),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: Color(0xFFFDB834),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color(0xFFFDB834)
                        : Color(0xFFFDB834).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Select',
                    style: TextStyle(
                      color: isSelected ? Colors.black : Color(0xFFFDB834),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
