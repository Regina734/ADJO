import 'package:adjo/pageAcceuille/acceuille2.dart';
import 'package:flutter/material.dart';

class AcceuillePage1 extends StatelessWidget {
  const AcceuillePage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001212),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Image.asset("assets/images/Group 39753.png")],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome To',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  const Text(
                    'Adjó',
                    style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),

              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _buildDot(true),
                      const SizedBox(width: 8),
                      _buildDot(false),
                      const SizedBox(width: 8),
                      _buildDot(false),
                    ],
                  ),
                  SizedBox(width: 350),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.amberAccent,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AcceuillePage2(),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDot(bool isActive) {
  return Container(
    width: isActive ? 24 : 8,
    height: 8,
    decoration: BoxDecoration(
      color: isActive ? const Color(0xFFFFD700) : Colors.grey[700],
      borderRadius: BorderRadius.circular(4),
    ),
  );
}
