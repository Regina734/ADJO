import 'package:flutter/material.dart';

class NextTourScreen extends StatelessWidget {
  const NextTourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Next Tour'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Text('Next Tour Screen', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
