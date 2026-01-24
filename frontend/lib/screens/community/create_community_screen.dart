import 'package:flutter/material.dart';

class CreateCommunityScreen extends StatefulWidget {
  const CreateCommunityScreen({Key? key}) : super(key: key);

  @override
  State<CreateCommunityScreen> createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController targetController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  final TextEditingController suggestionController = TextEditingController();
  final TextEditingController beneficiaryController = TextEditingController();

  String selectedVisibility = 'private';

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    targetController.dispose();
    deadlineController.dispose();
    suggestionController.dispose();
    beneficiaryController.dispose();
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
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Define how your community supports its members and makes decisions.',
              style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4),
            ),
            const SizedBox(height: 14),

            const Text(
              'Name of Community',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF3A3A2A),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFDB834), width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                decoration: InputDecoration(
                  hintText: 'Ex. Business Savings',
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 11),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  suffixIcon: const Icon(
                    Icons.edit,
                    color: Color(0xFFFDB834),
                    size: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            const Text(
              'Description of the goal',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[800]!, width: 1),
              ),
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: descriptionController,
                style: const TextStyle(color: Colors.white, fontSize: 11),
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'The goal of your community...',
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 11),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),

            const Text(
              'Target to be achieved (XOF)',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[800]!, width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: targetController,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Ex. 5000000',
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 11),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  suffixText: 'XOF',
                  suffixStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            const Text(
              'Collection deadline',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[800]!, width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: deadlineController,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'jj/mm/aaaa',
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 11),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  suffixIcon: const Icon(
                    Icons.calendar_today,
                    color: Color(0xFFFDB834),
                    size: 16,
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
                    deadlineController.text =
                        '${date.day}/${date.month}/${date.year}';
                  }
                },
              ),
            ),
            const SizedBox(height: 12),

            const Text(
              'Suggested contribution (Optional)',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[800]!, width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: suggestionController,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Ex. 5000',
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 11),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  suffixText: 'XOF',
                  suffixStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            const Text(
              'Visibility of the aid',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: _buildVisibilityOption(
                    title: 'Private',
                    icon: Icons.lock,
                    subtitle: 'By invitation only',
                    value: 'private',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildVisibilityOption(
                    title: 'Audience',
                    icon: Icons.group,
                    subtitle: 'Visible to everyone.',
                    value: 'audience',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            const Text(
              'Beneficiary',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[800]!, width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: beneficiaryController,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                decoration: InputDecoration(
                  hintText: "PERSON'S NAME",
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 11),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Colors.grey,
                    size: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFFFDB834),
                        width: 1,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        color: Color(0xFFFDB834),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/validate-community'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFDB834),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Validate',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
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
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF3A3A2A),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFFFDB834) : Colors.grey[800]!,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFFFDB834) : Colors.grey,
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 9,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
