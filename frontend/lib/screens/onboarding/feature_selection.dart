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
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'STEP 1 OF 4',
          style: TextStyle(
            color: Color(0xFFFDB834),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Color(0xFFFDB834)),
            onPressed: selectedFeature != null
                ? () => Navigator.pushNamed(
                    context,
                    '/feature-configuration',
                    arguments: selectedFeature,
                  )
                : null,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            const Text(
              'Choose your first\nfree feature',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Select a starting point to unlock your decentralized others later.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 11, height: 1.4),
            ),
            const SizedBox(height: 20),
            _buildFeatureCard(
              icon: Icons.people,
              title: 'Join a Community',
              description:
                  'Join a community and save together on the blockchain using smart contracts.',
              category: 'SOCIAL SAVING',
              value: 'community',
              isSelected: selectedFeature == 'community',
            ),
            const SizedBox(height: 12),
            _buildFeatureCard(
              icon: Icons.savings,
              title: 'Join a Tontine',
              description:
                  'Start your tontine and save together on the blockchain using smart contracts.',
              category: 'SOCIAL SAVING',
              value: 'tontine',
              isSelected: selectedFeature == 'tontine',
            ),
            const SizedBox(height: 12),
            _buildFeatureCard(
              icon: Icons.account_balance_wallet,
              title: 'My Box',
              description:
                  'Manage your personal savings with a secure, decentralized digital wallet.',
              category: 'SOCIAL SAVING',
              value: 'my_box',
              isSelected: selectedFeature == 'my_box',
            ),
            const SizedBox(height: 12),
            _buildFeatureCard(
              icon: Icons.school,
              title: 'Academy & Demo',
              description:
                  'Learn the ropes of DeFi and practice with a risk-free demo account before going live',
              category: 'EDUCATION',
              value: 'academy',
              isSelected: selectedFeature == 'academy',
            ),
            const SizedBox(height: 24),
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
    required String value,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFeature = isSelected ? null : value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF3A3A2A),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFFFDB834) : Colors.grey[800]!,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDB834).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: const Color(0xFFFDB834), size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFDB834),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.black,
                      size: 14,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Select',
                style: TextStyle(
                  color: isSelected ? const Color(0xFFFDB834) : Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
