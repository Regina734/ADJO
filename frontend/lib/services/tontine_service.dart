import 'package:adjo/mock-data/mock-data.dart';
import 'package:adjo/models/tontine.dart';

class TontineService {
  static final TontineService _instance = TontineService._internal();
  factory TontineService() => _instance;
  TontineService._internal();

  Future<List<Tontine>> getAllTontines() async {
    await MockData.simulateDelay(600);
    return MockData.tontines;
  }

  Future<List<Tontine>> getActiveTontines() async {
    await MockData.simulateDelay(500);
    return MockData.getActiveTontines();
  }

  Future<Tontine> createTontine({
    required String name,
    required double amount,
    required String frequency,
    required int maxMembers,
  }) async {
    await MockData.simulateDelay(1200);

    final newTontine = Tontine(
      id: 'tontine_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      amount: amount,
      frequency: frequency,
      maxMembers: maxMembers,
      currentMembers: 1,
      currentTurn: 0,
      status: 'pending',
      invitationCode: 'ADJO-${DateTime.now().year}-${_generateCode()}',
      createdAt: DateTime.now(),
      members: [],
    );

    MockData.tontines.add(newTontine);
    return newTontine;
  }

  Future<void> joinTontine(String invitationCode) async {
    await MockData.simulateDelay(800);
  }

  Future<Tontine> getTontineDetails(String id) async {
    await MockData.simulateDelay(400);
    return MockData.tontines.firstWhere((t) => t.id == id);
  }

  Future<void> payContribution(String tontineId, double amount) async {
    await MockData.simulateDelay(1500);
  }

  String _generateCode() {
    return List.generate(4, (i) => (i * 13) % 10).join();
  }
}
