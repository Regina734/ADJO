import 'package:adjo/screens/community/create_community_screen.dart';
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'My Community',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.access_time, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Invite Text
            const Text(
              '+ Invite other people to contribute to my membership fee. +',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12, height: 1.5),
            ),
            const SizedBox(height: 16),

            // Create Community Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateCommunityScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.black,
                  size: 20,
                ),
                label: const Text(
                  'Create my own community',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC4A052),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Total Stats
            FutureBuilder<List<Tontine>>(
              future: _tontineService.getAllTontines(),
              builder: (context, snapshot) {
                var totalAmount = 0.0;
                var totalAids = 0;

                if (snapshot.hasData) {
                  totalAids = snapshot.data!.length;
                  for (var tontine in snapshot.data!) {
                    totalAmount += tontine.amount * tontine.currentMembers;
                  }
                }

                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3A3A2A),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFF5A5A3A),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Collected',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  totalAmount.toStringAsFixed(0),
                                  style: const TextStyle(
                                    color: Color(0xFFFDB834),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 2),
                                  child: Text(
                                    'XOF',
                                    style: TextStyle(
                                      color: Color(0xFFFDB834),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3A3A2A),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFF5A5A3A),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Active Aids',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              totalAids.toString().padLeft(2, '0'),
                              style: const TextStyle(
                                color: Color(0xFFFDB834),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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

            // Active Aids List
            FutureBuilder<List<Tontine>>(
              future: _tontineService.getAllTontines(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: CircularProgressIndicator(
                        color: Color(0xFFFDB834),
                      ),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: Column(
                        children: [
                          Icon(
                            Icons.people_outline,
                            size: 60,
                            color: Colors.grey[700],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No active aids yet',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Create your first community aid',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // Simuler 3 cartes pour afficher les 3 états
                return Column(
                  children: [
                    _buildAidCard(snapshot.data![0], 'en_cours'),
                    if (snapshot.data!.length > 1)
                      _buildAidCard(snapshot.data![1], 'success'),
                    if (snapshot.data!.length > 2)
                      _buildAidCard(snapshot.data![2], 'finished'),
                    // Afficher les autres cartes normalement
                    ...snapshot.data!
                        .skip(3)
                        .map((tontine) => _buildAidCard(tontine, 'auto')),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAidCard(Tontine tontine, String statusOverride) {
    final totalCollected = tontine.amount * tontine.currentMembers;
    final targetTotal = tontine.amount * tontine.maxMembers;
    final progress = (targetTotal > 0) ? totalCollected / targetTotal : 0.0;

    // Déterminer le statut
    String status;
    if (statusOverride == 'auto') {
      final isFinished = progress >= 1.0;
      final daysRemaining = 12; // À calculer selon la deadline réelle

      if (isFinished) {
        status = 'success';
      } else if (daysRemaining > 0) {
        status = 'en_cours';
      } else {
        status = 'finished';
      }
    } else {
      status = statusOverride;
    }

    Color statusColor;
    String statusText;
    Color cardBorderColor;
    int daysRemaining = 12;

    switch (status) {
      case 'success':
        statusColor = const Color(0xFF4CAF50); // Vert
        statusText = 'SUCCESS';
        cardBorderColor = const Color(0xFF4A5A3A);
        break;
      case 'finished':
        statusColor = const Color(0xFF666666); // Gris
        statusText = 'FINISHED';
        cardBorderColor = const Color(0xFF4A4A3A);
        daysRemaining = 0;
        break;
      default: // en_cours
        statusColor = const Color(0xFFC4A052); // Jaune/Or
        statusText = 'EN COURS';
        cardBorderColor = const Color(0xFF5A5A3A);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A2A), // Fond olive/marron foncé
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cardBorderColor, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Badge and Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  statusText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (status == 'en_cours')
                Row(
                  children: [
                    Icon(Icons.access_time, size: 14, color: Colors.grey[400]),
                    const SizedBox(width: 4),
                    Text(
                      '$daysRemaining Days remaining',
                      style: TextStyle(color: Colors.grey[400], fontSize: 11),
                    ),
                  ],
                )
              else if (status == 'success')
                Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 14,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'FINISHED 12 Oct.',
                      style: TextStyle(color: Colors.grey[400], fontSize: 11),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Icon(
                      Icons.cancel_outlined,
                      size: 14,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Deadline passed',
                      style: TextStyle(color: Colors.grey[400], fontSize: 11),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Title
          Text(
            tontine.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),

          // Rule
          Text(
            'Rule : ${tontine.frequency}',
            style: TextStyle(color: Colors.grey[300], fontSize: 12),
          ),
          const SizedBox(height: 12),

          // Progress Label and Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              Row(
                children: [
                  Text(
                    '${totalCollected.toStringAsFixed(0)} / ${targetTotal.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'XOF',
                    style: TextStyle(color: Color(0xFFFDB834), fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: const Color(0xFF2A2A1A),
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
            ),
          ),
          const SizedBox(height: 12),

          // Donors and Action Buttons
          if (status == 'finished')
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Avatar Stack
                        SizedBox(
                          width: 60,
                          height: 28,
                          child: Stack(
                            children: List.generate(
                              3,
                              (index) => Positioned(
                                left: index * 18.0,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[600],
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFF3A3A2A),
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.person,
                                      size: 14,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${tontine.currentMembers} Donors',
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'RELAUNCH',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'PARTICIPATE IN THE PROJECT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                // Donors
                Row(
                  children: [
                    // Avatar Stack
                    SizedBox(
                      width: 80,
                      height: 28,
                      child: Stack(
                        children: List.generate(
                          tontine.currentMembers.clamp(0, 4),
                          (index) => Positioned(
                            left: index * 18.0,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.grey[600],
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF3A3A2A),
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  size: 14,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${tontine.currentMembers} Donors',
                      style: TextStyle(color: Colors.grey[300], fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Action Buttons
                if (status == 'success')
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'SEE THE EVIDENCE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFFC4A052),
                              width: 1.5,
                            ),
                            foregroundColor: const Color(0xFFC4A052),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'SEE THE EVIDENCE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC4A052),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'CONTRIBUTION',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
