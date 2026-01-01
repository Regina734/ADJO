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
  Widget? selectedPage;

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

    setState(() {
      selectedPage = page;
    });
  }

  void _onStartPressed() {
    if (selectedPage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => selectedPage!),
      );
    } else {
      // Afficher un message si aucune option n'est sélectionnée
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please choose an option first'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
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

              GestureDetector(
                onTap: selectedPage != null ? _onStartPressed : null,
                child: Container(
                  width: 300,
                  height: 60,
                  decoration: BoxDecoration(
                    color: selectedPage != null
                        ? Colors.white
                        : Colors.grey[800],
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: selectedPage != null
                          ? const Color(0xFFFDB834)
                          : Colors.grey[600]!,
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Start',
                      style: TextStyle(
                        color: selectedPage != null
                            ? Colors.black
                            : Colors.grey[600],
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
