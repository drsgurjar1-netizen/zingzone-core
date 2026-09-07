class UserModel {
  final String uid;
  final String name;
  final String email;
  final int coins;
  final bool squadUnlocked;
  final int freePrivateRoomsLeft;
  final String role; // 'user' ya 'admin'

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.coins = 0,
    this.squadUnlocked = false,
    this.freePrivateRoomsLeft = 5,
    this.role = 'user',
  });

  // Firestore se data padhne ke liye
  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      uid: id,
      name: map['name'] ?? 'User',
      email: map['email'] ?? '',
      coins: (map['coins'] ?? 0) as int,
      squadUnlocked: (map['squadUnlocked'] ?? false) as bool,
      freePrivateRoomsLeft: (map['freePrivateRoomsLeft'] ?? 5) as int,
      role: map['role'] ?? 'user',
    );
  }

  // Firestore me data save karne ke liye
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'coins': coins,
      'squadUnlocked': squadUnlocked,
      'freePrivateRoomsLeft': freePrivateRoomsLeft,
      'role': role,
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
    };
  }

  // Value update karne ke liye helper
  UserModel copyWith({
    int? coins,
    bool? squadUnlocked,
    int? freePrivateRoomsLeft,
  }) {
    return UserModel(
      uid: uid,
      name: name,
      email: email,
      coins: coins ?? this.coins,
      squadUnlocked: squadUnlocked ?? this.squadUnlocked,
      freePrivateRoomsLeft: freePrivateRoomsLeft ?? this.freePrivateRoomsLeft,
      role: role,
    );
  }
}
