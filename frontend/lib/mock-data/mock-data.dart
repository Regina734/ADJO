import 'package:adjo/models/community.dart';
import 'package:adjo/models/tontine.dart';
import 'package:adjo/models/transaction.dart';
import 'package:adjo/models/user.dart';

class MockData {
  static User demoUser = User(
    id: 'user_8829',
    name: 'Jean Jack',
    email: 'jean.jack@adjo.app',
    phone: '+229 97 00 00 00',
    walletAddress: 'GDJX_4KL2',
    avatar: null,
    subscription: 'free',
    isVerified: true,
    createdAt: DateTime(2022, 6, 15),
  );

  static List<Tontine> tontines = [
    Tontine(
      id: 'tontine_1',
      name: 'Circle of entrepreneurs',
      amount: 5000,
      frequency: 'monthly',
      maxMembers: 15,
      currentMembers: 12,
      currentTurn: 3,
      status: 'active',
      invitationCode: 'Ex:ADJO-2025-X8',
      createdAt: DateTime(2024, 1, 1),
      members: [
        TontineMember(
          userId: 'user_1',
          name: 'Kofi Mensah',
          reliability: 100,
          hasPaid: true,
          memberSince: 2022,
        ),
        TontineMember(
          userId: 'user_2',
          name: 'Amina Diallo',
          reliability: 75,
          hasPaid: false,
          memberSince: 2020,
        ),
      ],
    ),
    Tontine(
      id: 'tontine_2',
      name: 'Coopérative Karité Zem',
      amount: 2500,
      frequency: 'weekly',
      maxMembers: 10,
      currentMembers: 10,
      currentTurn: 1,
      status: 'active',
      invitationCode: 'ADJO-2025-KZ10',
      createdAt: DateTime(2024, 6, 1),
      members: [],
    ),
    Tontine(
      id: 'tontine_3',
      name: 'Marchands de Treichville',
      amount: 5000,
      frequency: 'monthly',
      maxMembers: 10,
      currentMembers: 5,
      currentTurn: 0,
      status: 'pending',
      invitationCode: 'ADJO-2025-MT5',
      createdAt: DateTime(2024, 10, 1),
      members: [],
    ),
  ];

  static List<Community> communities = [
    Community(
      id: 'comm_1',
      name: 'Medical expenses - Koné family',
      description: 'Support for medical treatment',
      targetAmount: 1000000,
      totalCollected: 750000,
      memberCount: 15,
      daysRemaining: 12,
      status: 'in_progress',
      invitationCode: 'ADJO-7728-SOLID',
      visibility: 'private',
      projects: [
        CommunityProject(
          name: 'Medical expenses - Koné family',
          rule: 'Voluntary contribution',
          progress: 750000,
          targetAmount: 1000000,
          donorsCount: 15,
          status: 'in_progress',
        ),
        CommunityProject(
          name: 'School fees support',
          rule: '5000F/members',
          progress: 780000,
          targetAmount: 1000000,
          donorsCount: 45,
          status: 'success',
        ),
      ],
    ),
  ];

  static List<Transaction> transactions = [
    Transaction(
      id: 'tx_1',
      type: 'staking_reward',
      amount: 100,
      date: DateTime.now().subtract(Duration(hours: 2)),
      status: 'completed',
      description: 'Staking Rewards',
    ),
    Transaction(
      id: 'tx_2',
      type: 'withdrawal',
      amount: -4000,
      date: DateTime.now().subtract(Duration(days: 1)),
      status: 'completed',
      description: 'Outgoing transfer',
    ),
    Transaction(
      id: 'tx_3',
      type: 'deposit',
      amount: 85000,
      date: DateTime.now().subtract(Duration(days: 3)),
      status: 'completed',
      description: 'Bank deposit',
    ),
  ];

  static Map<String, dynamic> myBoxData = {
    'totalBalance': 125000.50,
    'blockedBalance': 50000.0,
    'availableBalance': 75000.50,
    'savingGoal': 500000.0,
    'stakingAmount': 50000.0,
    'stakingRewards': 1250.75,
    'stakingAPY': 5.5,
  };

  static List<Map<String, dynamic>> academyModules = [
    {
      'id': 'module_1',
      'title': 'Blockchain 101',
      'description':
          'Discover what holds your digital value than in a traditional bank. No scary jargon, just the essentials.',
      'duration': 5,
      'progress': 0,
      'image': 'assets/images/blockchain101.jpg',
    },
    {
      'id': 'module_2',
      'title': 'What is Blockchain?',
      'description': 'Understanding decentralized technology',
      'duration': 8,
      'progress': 80,
      'image': 'assets/images/what_blockchain.jpg',
    },
    {
      'id': 'module_3',
      'title': 'Smart Contracts 101',
      'description': 'How automated agreements work',
      'duration': 10,
      'progress': 50,
      'image': 'assets/images/smart_contracts.jpg',
    },
    {
      'id': 'module_4',
      'title': 'Security & Keys',
      'description': 'Protecting your digital assets',
      'duration': 7,
      'progress': 30,
      'image': 'assets/images/security.jpg',
    },
  ];

  // Staking data
  static List<Map<String, dynamic>> stakingPlans = [
    {
      'id': 'stake_1',
      'amount': 50000,
      'duration': 3, // months
      'lockDate': DateTime.now(),
      'unlockDate': DateTime.now().add(const Duration(days: 90)),
      'apy': 5.5,
      'estimatedRewards': 687.50,
      'status': 'locked',
    },
    {
      'id': 'stake_2',
      'amount': 100000,
      'duration': 6,
      'lockDate': DateTime.now().subtract(const Duration(days: 30)),
      'unlockDate': DateTime.now().add(const Duration(days: 150)),
      'apy': 7.2,
      'estimatedRewards': 3600.0,
      'status': 'locked',
    },
    {
      'id': 'stake_3',
      'amount': 25000,
      'duration': 1,
      'lockDate': DateTime.now().subtract(const Duration(days: 20)),
      'unlockDate': DateTime.now().add(const Duration(days: 10)),
      'apy': 3.0,
      'estimatedRewards': 62.50,
      'status': 'available_unlock',
    },
  ];

  static List<Map<String, dynamic>> stakingTiers = [
    {
      'name': 'Starter',
      'minAmount': 10000,
      'maxAmount': 100000,
      'apy': 3.5,
      'lockPeriod': 1,
      'description': '3.5% APY - 1 month lock',
    },
    {
      'name': 'Standard',
      'minAmount': 100000,
      'maxAmount': 500000,
      'apy': 5.5,
      'lockPeriod': 3,
      'description': '5.5% APY - 3 months lock',
    },
    {
      'name': 'Premium',
      'minAmount': 500000,
      'maxAmount': null,
      'apy': 7.2,
      'lockPeriod': 6,
      'description': '7.2% APY - 6 months lock',
    },
  ];

  // Daily Quiz data
  static List<Map<String, dynamic>> dailyQuizzes = [
    {
      'id': 'quiz_1',
      'question':
          'What is the main advantage of using blockchain for tontines?',
      'options': [
        'Lower fees',
        'Transparency and security',
        'Faster transactions',
        'Better interest rates',
      ],
      'correctAnswer': 1,
      'explanation':
          'Blockchain provides transparency through immutable records and security through cryptography.',
      'points': 50,
      'difficulty': 'easy',
    },
    {
      'id': 'quiz_2',
      'question': 'How does ADJO ensure the security of your funds?',
      'options': [
        'Only through traditional banking',
        'Smart contracts and blockchain verification',
        'User passwords only',
        'No security measures',
      ],
      'correctAnswer': 1,
      'explanation':
          'ADJO uses blockchain smart contracts and cryptographic verification to secure transactions.',
      'points': 75,
      'difficulty': 'medium',
    },
    {
      'id': 'quiz_3',
      'question': 'What is the benefit of decentralized tontines?',
      'options': [
        'Higher fees',
        'No transparency',
        'No single point of failure and increased trust',
        'Slower transactions',
      ],
      'correctAnswer': 2,
      'explanation':
          'Decentralized systems eliminate single points of failure and increase transparency through distributed verification.',
      'points': 100,
      'difficulty': 'hard',
    },
    {
      'id': 'quiz_4',
      'question': 'What does APY stand for in staking?',
      'options': [
        'Annual Percentage Yield',
        'Annual Payment Year',
        'Account Payment Yield',
        'Annual Performance Yield',
      ],
      'correctAnswer': 0,
      'explanation':
          'APY (Annual Percentage Yield) represents the annual return on investment including compound interest.',
      'points': 50,
      'difficulty': 'easy',
    },
    {
      'id': 'quiz_5',
      'question': 'What is the lock period for Premium staking tier?',
      'options': ['1 month', '3 months', '6 months', '12 months'],
      'correctAnswer': 2,
      'explanation':
          'The Premium tier requires a 6-month lock period and offers 7.2% APY.',
      'points': 75,
      'difficulty': 'medium',
    },
  ];

  static Map<String, dynamic> get todayQuiz {
    return dailyQuizzes[0]; // Return first quiz for today
  }

  static Future<void> simulateDelay([int milliseconds = 800]) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }

  static List<Tontine> getActiveTontines() {
    return tontines.where((t) => t.status == 'active').toList();
  }

  static List<Transaction> getRecentTransactions({int limit = 3}) {
    return transactions.take(limit).toList();
  }

  static double getTotalBalance() {
    return myBoxData['totalBalance'];
  }

  static int getActiveTontinesCount() {
    return tontines.where((t) => t.status == 'active').length;
  }
}
