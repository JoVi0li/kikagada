import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/external/extensions/user_entity_extension.dart';
import 'package:kikagada/modules/auth/infra/datasources/auth_datasource.dart';

class FirebaseAuthDatasourceImp implements IAuthDatasource {
  final FirebaseAuth _auth;

  FirebaseAuthDatasourceImp({required FirebaseAuth auth}) : _auth = auth;

  @override
  Future<UserEntity> loginWithApple() {
    // TODO: implement loginWithApple
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> loginWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();

    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);

    final user = UserEntityExtension.fromFirebase(userCredential.user!);

    return user;
  }
}
