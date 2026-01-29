import 'package:flutter/material.dart';
import '../../services/tontine_service.dart';
import '../../models/tontine.dart';

class MyTontineScreen extends StatefulWidget {
  const MyTontineScreen({Key? key}) : super(key: key);

  @override
  State<MyTontineScreen> createState() => _MyTontineScreenState();
}

class _MyTontineScreenState extends State<MyTontineScreen> {
  late final TontineService _tontineService = TontineService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: FutureBuilder<List<Tontine>>(
        future: _tontineService.getAllTontines(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My Tontine',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.inbox_rounded,
                        size: 60,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No tontines yet',
                        style: TextStyle(color: Colors.grey[400], fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Create your first tontine to get started',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          final tontines = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Tontine',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tontines.length,
                itemBuilder: (context, index) {
                  final tontine = tontines[index];
                  return _buildTontineCard(tontine);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTontineCard(Tontine tontine) {
    final totalCollected = tontine.amount * tontine.currentMembers;
    final targetTotal = tontine.amount * tontine.maxMembers;
    final progress = totalCollected / targetTotal;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
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
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${tontine.frequency} rotation',
                      style: const TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDB834).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${tontine.currentMembers}/${tontine.maxMembers} members',
                  style: const TextStyle(
                    color: Color(0xFFFDB834),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: Colors.grey[800],
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFFDB834),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Amount info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${(tontine.amount * tontine.currentMembers).toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Color(0xFFFDB834),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${(tontine.amount * tontine.maxMembers).toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Action button
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFDB834),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // TODO: Implement contribution logic
              },
              child: const Text(
                'Contribute',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
