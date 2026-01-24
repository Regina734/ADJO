import 'package:flutter/material.dart';

class UpgradePremiumModal extends StatefulWidget {
  const UpgradePremiumModal({Key? key}) : super(key: key);

  @override
  State<UpgradePremiumModal> createState() => _UpgradePremiumModalState();
}

class _UpgradePremiumModalState extends State<UpgradePremiumModal>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
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
          'Morcals forfait',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFFFDB834),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'F',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _tabController.animateTo(0),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _tabController.index == 0
                            ? const Color(0xFFFDB834)
                            : Colors.transparent,
                        foregroundColor: _tabController.index == 0
                            ? Colors.black
                            : Colors.white,
                        elevation: 0,
                        side: BorderSide(
                          color: _tabController.index == 0
                              ? const Color(0xFFFDB834)
                              : Colors.grey[800]!,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Monthly',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _tabController.animateTo(1),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _tabController.index == 1
                            ? const Color(0xFFFDB834)
                            : Colors.transparent,
                        foregroundColor: _tabController.index == 1
                            ? Colors.black
                            : Colors.white,
                        elevation: 0,
                        side: BorderSide(
                          color: _tabController.index == 1
                              ? const Color(0xFFFDB834)
                              : Colors.grey[800]!,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Annual',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 550,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPricingPlans(isAnnual: false),
                  _buildPricingPlans(isAnnual: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingPlans({required bool isAnnual}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildPlanCard(
            title: 'Basic',
            price: 'Free',
            features: [
              'Staking & Rewards',
              'limited Tontines (up to 1)',
              'Daily Rewards Quiz',
              'My communities',
              'Minimum fees (2%)',
            ],
            isRecommended: false,
            isSelected: false,
          ),
          const SizedBox(height: 12),
          _buildPlanCard(
            title: 'Premium',
            price: isAnnual ? '\$50' : '\$5',
            period: isAnnual ? '/year' : '/month',
            features: [
              'Staking & Rewards',
              'limited Tontines(up to 3)',
              'My Communities',
              'Daily Rewards Quiz',
              'My Box',
              'Lowest Platform fees (0.5%)',
            ],
            isRecommended: true,
            isSelected: false,
          ),
          const SizedBox(height: 12),
          _buildPlanCard(
            title: 'EXPERT Pro',
            price: isAnnual ? '\$150' : '\$15',
            period: isAnnual ? '/year' : '/month',
            features: [
              'Staking & Rewards',
              'unlimited Tontines',
              'My Communities',
              'Daily Rewards Quiz',
              'My Box',
              'Lowest Platform fees(0.1%)',
            ],
            isRecommended: false,
            isSelected: false,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
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
                'UPGRADE NOW',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Text(
              'Maybe later',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 11,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF3A3A2A),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[800]!, width: 1),
            ),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFDB834),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, size: 12, color: Colors.black),
                ),
                const SizedBox(width: 8),
                const Text(
                  'My communities',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
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

  Widget _buildPlanCard({
    required String title,
    required String price,
    String? period,
    required List<String> features,
    required bool isRecommended,
    required bool isSelected,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A2A),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isRecommended ? const Color(0xFFFDB834) : Colors.grey[800]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isRecommended)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFDB834),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'RECOMMEND',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Color(0xFFFDB834),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (period != null)
                Text(
                  period,
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(color: Colors.grey[800], height: 1),
          const SizedBox(height: 10),
          ...features.map((feature) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8, top: 2),
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDB834),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 12,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      feature,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
