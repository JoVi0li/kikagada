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
  })  : assert(id.isNotEmpty, 'id property can not be empty'),
        assert(name.isNotEmpty, 'name property can not be empty'),
        assert(email.isNotEmpty, 'email property can not be empty'),
        assert(email.contains('@'), 'email property value is invalid');

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      photo: map['photo'],
    );
  }
}
