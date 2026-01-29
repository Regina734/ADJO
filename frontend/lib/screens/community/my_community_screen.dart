import 'package:flutter/material.dart';
import '../../services/tontine_service.dart';
import '../../models/tontine.dart';

class MyCommunityScreen extends StatefulWidget {
  const MyCommunityScreen({Key? key}) : super(key: key);

  @override
  State<MyCommunityScreen> createState() => _MyCommunityScreenState();
}

class _MyCommunityScreenState extends State<MyCommunityScreen> {
  late final TontineService _tontineService = TontineService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Invite Text
          const Text(
            '+ Invite other people to contribute to my memberships fee.',
            style: TextStyle(color: Colors.grey, fontSize: 12, height: 1.5),
          ),
          const SizedBox(height: 20),

          // Create Tontine Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/create-tontine');
              },
              icon: const Icon(Icons.add, color: Colors.black, size: 20),
              label: const Text(
                'Create my own tontine',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFDB834),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Total Stats
          FutureBuilder<List<Tontine>>(
            future: _tontineService.getAllTontines(),
            builder: (context, snapshot) {
              var totalAmount = 0.0;
              var totalMembers = 0;

              if (snapshot.hasData) {
                for (var tontine in snapshot.data!) {
                  totalAmount += tontine.amount * tontine.currentMembers;
                  totalMembers += tontine.currentMembers;
                }
              }

              return Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A3A2A),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFFDB834),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Collected',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            totalAmount.toStringAsFixed(0),
                            style: const TextStyle(
                              color: Color(0xFFFDB834),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'XOF',
                            style: TextStyle(
                              color: Color(0xFFFDB834),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A3A2A),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFFDB834),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Active Members',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            totalMembers.toString(),
                            style: const TextStyle(
                              color: Color(0xFFFDB834),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Members',
                            style: TextStyle(
                              color: Color(0xFFFDB834),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),

          // My Tontines List
          const Text(
            'My Tontines',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          FutureBuilder<List<Tontine>>(
            future: _tontineService.getAllTontines(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 50,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No tontines yet',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return _buildTontineCard(snapshot.data![index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTontineCard(Tontine tontine) {
    final totalCollected = tontine.amount * tontine.currentMembers;
    final targetTotal = tontine.amount * tontine.maxMembers;
    final progress = (targetTotal > 0) ? totalCollected / targetTotal : 0.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!, width: 0.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tontine.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${tontine.frequency} • ${tontine.currentMembers} members',
                      style: const TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDB834).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '\$${totalCollected.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Color(0xFFFDB834),
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 6,
              backgroundColor: Colors.grey[800],
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFFDB834),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
