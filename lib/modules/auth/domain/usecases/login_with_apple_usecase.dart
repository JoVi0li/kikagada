import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/errors/auth_errors.dart';
import 'package:kikagada/modules/auth/domain/repositories/auth_repository.dart';

abstract class LoginWithAppleUsecase {
  Future<(UserEntity? user, AuthError? error)> call();
}

class LoginWithAppleUsecaseImp implements LoginWithAppleUsecase {
  final AuthRepository _repository;

  LoginWithAppleUsecaseImp({required AuthRepository repository}) : _repository = repository;

  @override
  Future<(UserEntity? user, AuthError? error)> call() async {
    return await _repository.loginWithApple();
  }
}
