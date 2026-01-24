class Tontine {
  final String id;
  final String name;
  final double amount;
  final String frequency; // 'weekly', 'monthly'
  final int maxMembers;
  final int currentMembers;
  final int currentTurn;
  final String status; // 'pending', 'active', 'completed'
  final String invitationCode;
  final DateTime createdAt;
  final List<TontineMember> members;

  Tontine({
    required this.id,
    required this.name,
    required this.amount,
    required this.frequency,
    required this.maxMembers,
    required this.currentMembers,
    required this.currentTurn,
    required this.status,
    required this.invitationCode,
    required this.createdAt,
    this.members = const [],
  });

  factory Tontine.fromJson(Map<String, dynamic> json) => Tontine(
    id: json['id'],
    name: json['name'],
    amount: json['amount'].toDouble(),
    frequency: json['frequency'],
    maxMembers: json['max_members'],
    currentMembers: json['current_members'],
    currentTurn: json['current_turn'],
    status: json['status'],
    invitationCode: json['invitation_code'],
    createdAt: DateTime.parse(json['created_at']),
    members:
        (json['members'] as List?)
            ?.map((m) => TontineMember.fromJson(m))
            .toList() ??
        [],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'amount': amount,
    'frequency': frequency,
    'max_members': maxMembers,
    'current_members': currentMembers,
    'current_turn': currentTurn,
    'status': status,
    'invitation_code': invitationCode,
    'created_at': createdAt.toIso8601String(),
    'members': members.map((m) => m.toJson()).toList(),
  };
}

class TontineMember {
  final String userId;
  final String name;
  final String? avatar;
  final double reliability; // 0-100%
  final bool hasPaid;
  final int memberSince; // année

  TontineMember({
    required this.userId,
    required this.name,
    this.avatar,
    required this.reliability,
    required this.hasPaid,
    required this.memberSince,
  });

  factory TontineMember.fromJson(Map<String, dynamic> json) => TontineMember(
    userId: json['user_id'],
    name: json['name'],
    avatar: json['avatar'],
    reliability: json['reliability'].toDouble(),
    hasPaid: json['has_paid'],
    memberSince: json['member_since'],
  );

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'name': name,
    'avatar': avatar,
    'reliability': reliability,
    'has_paid': hasPaid,
    'member_since': memberSince,
  };
}
