import 'package:flutter/material.dart';

class CreateCommunityScreen extends StatefulWidget {
  const CreateCommunityScreen({Key? key}) : super(key: key);

  @override
  State<CreateCommunityScreen> createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _suggestionController = TextEditingController();
  final TextEditingController _beneficiaryController = TextEditingController();

  String selectedVisibility = 'private';

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _targetController.dispose();
    _deadlineController.dispose();
    _suggestionController.dispose();
    _beneficiaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Create Community',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Define how your community supports its\nmembers and makes decisions.',
              style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4),
            ),
            const SizedBox(height: 20),

            // NAME OF COMMUNITY
            const Text(
              'NAME OF COMMUNITY', // MAJUSCULES comme l'image
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold, // Plus gras
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF4A4A3A), // Gris foncé comme l'image
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Ex: Business Savings',
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 13),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(Icons.edit, color: Colors.white, size: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // DESCRIPTION OF THE GOAL
            const Text(
              'DESCRIPTION OF THE GOAL', // MAJUSCULES
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF4A4A3A), // Gris foncé
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _descriptionController,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'The goal of your community...',
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 13),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // TARGET TO BE ACHIEVED
            const Text(
              'TARGET TO BE ACHIEVED (XOF)', // MAJUSCULES
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF4A4A3A), // Gris foncé
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: TextField(
                      controller: _targetController,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Ex: 5000000',
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFDB834),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'XOF',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // COLLECTION DEADLINE
            const Text(
              'COLLECTION DEADLINE', // MAJUSCULES
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF4A4A3A), // Gris foncé
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _deadlineController,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'jj/mm/aaaa',
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 13),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    _deadlineController.text =
                        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
                  }
                },
              ),
            ),
            const SizedBox(height: 16),

            // SUGGESTED CONTRIBUTION
            const Text(
              'SUGGESTED CONTRIBUTION (OPTIONAL)', // MAJUSCULES
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF4A4A3A), // Gris foncé
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: TextField(
                      controller: _suggestionController,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Ex: 5000',
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFDB834),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'XOF',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // VISIBILITY OF THE AID
            const Text(
              'VISIBILITY OF THE AID', // MAJUSCULES
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildVisibilityOption(
                    title: 'Private',
                    icon: Icons.lock, // Icône plus simple comme l'image
                    subtitle: 'By invitation only.', // Texte sur une ligne
                    value: 'private',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildVisibilityOption(
                    title: 'Audience',
                    icon: Icons.group, // Icône plus simple
                    subtitle: 'Visible to everyone.', // Texte sur une ligne
                    value: 'audience',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // BENEFICIARY
            const Text(
              'BENEFICIARY', // MAJUSCULES
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF4A4A3A), // Gris foncé
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _beneficiaryController,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: "PERSON'S NAME",
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 13),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 12, right: 8),
                    child: Icon(
                      Icons.person_outline,
                      color: Colors.grey,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // BUTTONS (Correction importante)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/validate-community');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFDB834), // Jaune
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Validate',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    // Bouton avec bordure, pas ElevatedButton
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.transparent, // Fond transparent
                      side: const BorderSide(color: Colors.white, width: 1),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.white, // Texte blanc
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildVisibilityOption({
    required String title,
    required IconData icon,
    required String subtitle,
    required String value,
  }) {
    final isSelected = selectedVisibility == value;
    return GestureDetector(
      onTap: () => setState(() => selectedVisibility = value),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF4A4A3A), // Gris foncé
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFFFDB834) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 11,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
