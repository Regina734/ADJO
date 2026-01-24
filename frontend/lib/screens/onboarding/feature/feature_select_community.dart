import 'package:flutter/material.dart';

class SelectCommunityScreen extends StatelessWidget {
  const SelectCommunityScreen({Key? key}) : super(key: key);

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
          'STEP 1 OF 4',
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
            onPressed: () {},
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
                value: 0.25,
                backgroundColor: Colors.grey[800],
                valueColor: AlwaysStoppedAnimation(Color(0xFFFDB834)),
              ),
            ),

            SizedBox(height: 30),

            // Titre
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Join a\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Community',
                          style: TextStyle(
                            color: Color(0xFFFDB834),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Enter an invitation code or discover\ncommunities near you.',
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

            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  // Bouton Create my own community
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Color(0xFF3D3420),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFFFDB834).withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.add, color: Color(0xFFFDB834)),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Create my own community',
                          style: TextStyle(
                            color: Color(0xFFFDB834),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Card EN COURS
                  _buildCommunityCard(
                    badge: 'EN COURS',
                    badgeColor: Color(0xFFFDB834),
                    daysRemaining: '12 Days remaining',
                    title: 'Medical expenses - Koné family',
                    rule: 'Voluntary contribution',
                    progress: 750000,
                    target: 1000000,
                    donors: 15,
                    button1Text: 'SEE THE EVIDENCE',
                    button2Text: 'CONTRIBUTION',
                    button1Color: Color(0xFF3D3420),
                    button2Color: Color(0xFFFDB834),
                  ),

                  SizedBox(height: 16),

                  // Card SUCCESS
                  _buildCommunityCard(
                    badge: 'SUCCESS',
                    badgeColor: Color(0xFF4CAF50),
                    daysRemaining: 'FINISHED 10 Oct.',
                    title: 'Medical expenses - Koné family',
                    rule: null,
                    progress: 750000,
                    target: 1000000,
                    donors: 45,
                    button1Text: 'SEE THE EVIDENCE',
                    button2Text: null,
                    button1Color: Color(0xFF4CAF50),
                    button2Color: null,
                  ),

                  SizedBox(height: 16),

                  // Card FINISHED
                  _buildCommunityCard(
                    badge: 'FINISHED',
                    badgeColor: Colors.grey,
                    daysRemaining: 'Deadline passed',
                    title: 'Medical expenses - Koné family',
                    rule: '5000F/ members',
                    progress: 750000,
                    target: 1000000,
                    donors: 15,
                    button1Text: null,
                    button2Text: null,
                    button1Color: null,
                    button2Color: null,
                    isFinished: true,
                  ),

                  SizedBox(height: 100),
                ],
              ),
            ),

            // Bouton Continue
            Padding(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFDB834),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunityCard({
    required String badge,
    required Color badgeColor,
    required String daysRemaining,
    required String title,
    String? rule,
    required double progress,
    required double target,
    required int donors,
    String? button1Text,
    String? button2Text,
    Color? button1Color,
    Color? button2Color,
    bool isFinished = false,
  }) {
    double percentage = (progress / target * 100).clamp(0, 100);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF3D3420),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge et Days remaining
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: badgeColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: badgeColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.grey, size: 14),
                  SizedBox(width: 4),
                  Text(
                    daysRemaining,
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 12),

          // Titre
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          if (rule != null) ...[
            SizedBox(height: 4),
            Text(
              'Rule : $rule',
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
          ],

          SizedBox(height: 12),

          // Progress
          Text(
            'Progress',
            style: TextStyle(color: Colors.grey[400], fontSize: 12),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${progress.toInt()} / ${target.toInt()} XOF',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation(Color(0xFFFDB834)),
              minHeight: 8,
            ),
          ),

          SizedBox(height: 12),

          // Donors
          Row(
            children: [
              ...List.generate(
                4,
                (index) => Container(
                  margin: EdgeInsets.only(right: 4),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Center(
                    child: Icon(Icons.person, color: Colors.white, size: 14),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                '$donors Donors',
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
            ],
          ),

          if (button1Text != null || button2Text != null) ...[
            SizedBox(height: 16),
            Row(
              children: [
                if (button1Text != null)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: button1Color,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        button1Text,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                if (button1Text != null && button2Text != null)
                  SizedBox(width: 8),
                if (button2Text != null)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: button2Color,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        button2Text,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
