class Community {
  final String id;
  final String name;
  final String? description;
  final double targetAmount;
  final double totalCollected;
  final int memberCount;
  final int daysRemaining;
  final String status; // 'in_progress', 'success', 'finished'
  final String invitationCode;
  final String visibility; // 'private', 'public'
  final List<CommunityProject> projects;

  Community({
    required this.id,
    required this.name,
    this.description,
    required this.targetAmount,
    required this.totalCollected,
    required this.memberCount,
    required this.daysRemaining,
    required this.status,
    required this.invitationCode,
    required this.visibility,
    this.projects = const [],
  });

  factory Community.fromJson(Map<String, dynamic> json) => Community(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    targetAmount: json['target_amount'].toDouble(),
    totalCollected: json['total_collected'].toDouble(),
    memberCount: json['member_count'],
    daysRemaining: json['days_remaining'],
    status: json['status'],
    invitationCode: json['invitation_code'],
    visibility: json['visibility'],
    projects:
        (json['projects'] as List?)
            ?.map((p) => CommunityProject.fromJson(p))
            .toList() ??
        [],
  );

  double get progress => (totalCollected / targetAmount * 100).clamp(0, 100);
}

class CommunityProject {
  final String name;
  final String rule;
  final double progress;
  final double targetAmount;
  final int donorsCount;
  final String status;

  CommunityProject({
    required this.name,
    required this.rule,
    required this.progress,
    required this.targetAmount,
    required this.donorsCount,
    required this.status,
  });

  factory CommunityProject.fromJson(Map<String, dynamic> json) =>
      CommunityProject(
        name: json['name'],
        rule: json['rule'],
        progress: json['progress'].toDouble(),
        targetAmount: json['target_amount'].toDouble(),
        donorsCount: json['donors_count'],
        status: json['status'],
      );
}
