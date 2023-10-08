class UserEntity {
  final String id;
  final String name;
  final String email;
  final String? photo;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
  });

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      photo: map['photo'],
    );
  }
}
