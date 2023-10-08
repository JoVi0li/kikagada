import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/errors/auth_errors.dart';
import 'package:kikagada/modules/auth/domain/repositories/auth_repository.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_apple_usecase/login_with_apple_usecase.dart';

final class LoginWithAppleUsecaseImp implements ILoginWithAppleUsecase {
  final IAuthRepository _repository;

  LoginWithAppleUsecaseImp({required IAuthRepository repository})
      : _repository = repository;

  @override
  Future<(UserEntity? user, AuthError? error)> call() async {
    return await _repository.loginWithApple();
  }
}
