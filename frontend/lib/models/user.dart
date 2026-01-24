class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? walletAddress;
  final String? avatar;
  final String subscription; // 'free', 'premium', 'pro'
  final bool isVerified;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.walletAddress,
    this.avatar,
    required this.subscription,
    required this.isVerified,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    phone: json['phone'],
    walletAddress: json['wallet_address'],
    avatar: json['avatar'],
    subscription: json['subscription'],
    isVerified: json['is_verified'] ?? false,
    createdAt: DateTime.parse(json['created_at']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'wallet_address': walletAddress,
    'avatar': avatar,
    'subscription': subscription,
    'is_verified': isVerified,
    'created_at': createdAt.toIso8601String(),
  };
}
