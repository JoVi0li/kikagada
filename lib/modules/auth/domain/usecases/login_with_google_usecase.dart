import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/errors/auth_errors.dart';
import 'package:kikagada/modules/auth/domain/repositories/auth_repository.dart';

abstract class LoginWithGoogleUsecase {
  Future<(UserEntity? user, AuthError? error)> call();
}

class LoginWithGoogleUsecaseImp implements LoginWithGoogleUsecase {
  final AuthRepository _repository;

  LoginWithGoogleUsecaseImp({required AuthRepository repository})
      : _repository = repository;

  @override
  Future<(UserEntity? user, AuthError? error)> call() async {
    return await _repository.loginWithGoogle();
  }
}
