import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/repositories/auth_repository.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_google_usecase/login_with_google_usecase.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';

final class LoginWithGoogleUsecaseImp implements ILoginWithGoogleUsecase {
  final IAuthRepository _repository;

  LoginWithGoogleUsecaseImp({required IAuthRepository repository})
      : _repository = repository;

  @override
  Future<(UserEntity? user, BaseException? error)> call() async {
    return await _repository.loginWithGoogle();
  }
}
