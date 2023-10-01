import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/external/extensions/user_entity_extension.dart';
import 'package:kikagada/modules/auth/infra/datasources/auth_datasource.dart';

class FirebaseAuthDatasourceImp implements AuthDatasource {
  @override
  Future<UserEntity> loginWithApple() {
    // TODO: implement loginWithApple
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final user = UserEntityExtension.fromFirebase(userCredential.user!);

      return user;
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }
}
