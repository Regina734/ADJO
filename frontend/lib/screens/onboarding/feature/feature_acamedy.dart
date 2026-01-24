import 'package:flutter/material.dart';

class AcademyIntroScreen extends StatelessWidget {
  const AcademyIntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFDB834)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'STEP 4 OF 4',
          style: TextStyle(color: Colors.white, fontSize: 12),
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
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                height: 3,
                child: LinearProgressIndicator(
                  value: 1.0,
                  backgroundColor: Colors.grey[800],
                  valueColor: AlwaysStoppedAnimation(Color(0xFFFDB834)),
                ),
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFF3D3420),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Adjo ACADEMY',
                  style: TextStyle(color: Color(0xFFFDB834), fontSize: 12),
                ),
              ),
              SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Welcome to the\n',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Academy',
                      style: TextStyle(
                        color: Color(0xFFFDB834),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Unlock the power of decentralized finance with simple, byte-sized lessons.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Color(0xFF3D3420),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Icon(Icons.lock, color: Color(0xFFFDB834), size: 60),
                    SizedBox(height: 12),
                    Text(
                      'First Module 5 min',
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Blockchain 101',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Discover why your savings are safer in a digital vault than in a traditional bank. No technical jargon just the essentials.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[400], fontSize: 13),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 6,
                      child: LinearProgressIndicator(
                        value: 0.0,
                        backgroundColor: Colors.grey[800],
                        valueColor: AlwaysStoppedAnimation(Color(0xFFFDB834)),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Unlock in remaining',
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                        Text(
                          '0%',
                          style: TextStyle(
                            color: Color(0xFFFDB834),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF3D3420),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'EARN XP',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF3D3420),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Daily Quiz',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFDB834),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Launch the first course',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'You can pause and resume at any time',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
