import 'package:adjo/homeFqa/groupT.dart';
import 'package:adjo/homeFqa/individualT.dart';
import 'package:adjo/homeFqa/tontine.dart';
import 'package:flutter/material.dart';

class HomechoisePage extends StatefulWidget {
  const HomechoisePage({super.key});

  @override
  State<HomechoisePage> createState() => _HomechoisePageState();
}

class _HomechoisePageState extends State<HomechoisePage> {
  String? selectedTontine;

  final List<Map<String, dynamic>> tontineOptions = [
    {'name': 'Create a Tontine ', 'page': 'CreateTontinePage'},
    {
      'name': 'Create an individual vault',
      'page': 'CreateInduvidalTontinePage',
    },
    {'name': 'Create a group chest', 'page': 'CreategroupTontinePage'},
  ];

  void navigateToTontine(String pageName) {
    // Navigation selon la page sélectionnée
    switch (pageName) {
      case 'CreateTontinePage':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateTontinePage()),
        );
        break;
      case 'CreateInduvidalTontinePage':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreateInduvidalTontinePage(),
          ),
        );
        break;
      case 'CreategroupTontinePage':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreategroupTontinePage(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(flex: 2),

              Center(
                child: Container(
                  width: 200,
                  height: 200,

                  child: Center(
                    child: Image.asset(
                      "assets/images/Group 39753.png",
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                'Adjó',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              const Text(
                'Unleash your financial\npotential',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(flex: 2),

              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFFDB834),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedTontine,
                    hint: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Choose your tontine',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFFFDB834),
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                    isExpanded: true,
                    icon: const SizedBox.shrink(),
                    dropdownColor: const Color(0xFFFDB834),
                    items: tontineOptions.map((option) {
                      return DropdownMenuItem<String>(
                        value: option['name'],
                        child: Text(
                          option['name'],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTontine = newValue;
                      });

                      if (newValue != null) {
                        final selectedOption = tontineOptions.firstWhere(
                          (option) => option['name'] == newValue,
                        );
                        navigateToTontine(selectedOption['page']);
                      }
                    },
                  ),
                ),
              ),

              const Spacer(flex: 1),

              // je dois faire une demo
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 32,
                ),
              ),

              const Spacer(flex: 2),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Scaffold()),
                  );
                  /*ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Commençons !'),
                      backgroundColor: Color(0xFFFDB834),
                    ),
                  );*/
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(0xFFFDB834),
                      width: 3,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Start',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
