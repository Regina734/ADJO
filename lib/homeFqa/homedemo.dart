import 'package:adjo/homeFqa/community.dart';
import 'package:adjo/homeFqa/mybox.dart';
import 'package:adjo/homeFqa/tontine.dart';
import 'package:adjo/widgetPage/videopage.dart';
import 'package:flutter/material.dart';

class HomechoisePage extends StatefulWidget {
  const HomechoisePage({super.key});

  @override
  State<HomechoisePage> createState() => _HomechoisePageState();
}

class _HomechoisePageState extends State<HomechoisePage> {
  String? selectedTontine;

  // Liste des options
  final List<Map<String, String>> tontineOptions = [
    {'name': 'Create a Tontine', 'page': 'CreateTontinePage'},
    {'name': 'Create my box', 'page': 'CreatemyBoxPage'},
    {'name': 'Create my community', 'page': 'CreatemyCommunityPage'},
  ];

  void navigateToTontine(String pageName) {
    Widget? page;

    switch (pageName) {
      case 'CreateTontinePage':
        page = const CreateTontinePage();
        break;
      case 'CreatemyBoxPage':
        page = const CreatemyBoxPage();
        break;
      case 'CreatemyCommunityPage':
        page = const CreatemyCommunityPage();
        break;
    }

    if (page != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Scaffold()),
      );
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

              // Logo
              Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    "assets/images/Group 39753.png",
                    width: 200,
                    height: 200,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Titre
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

              // Sous-titre
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

              // Dropdown
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
                          option['name']!,
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
                        navigateToTontine(selectedOption['page']!);
                      }
                    },
                  ),
                ),
              ),

              const Spacer(flex: 1),

              // Bouton vidéo
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VideoDemoPage(),
                    ),
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
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
              ),

              const Spacer(flex: 2),

              // Bouton Start
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const Scaffold(), // Remplacez par votre page
                    ),
                  );
                },
                child: Container(
                  width: 300,
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
