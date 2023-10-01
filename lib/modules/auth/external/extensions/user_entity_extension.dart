import 'package:firebase_auth/firebase_auth.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';

extension UserEntityExtension on UserEntity {
  static UserEntity fromFirebase(User user) {
    return UserEntity(
      id: user.uid,
      name: user.displayName!,
      email: user.email!,
      photo: user.photoURL,
    );
  }
}
