import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/repositories/auth_repository.dart';
import 'package:kikagada/modules/auth/domain/usecases/get_user_usecase/get_user_usecase.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';

final class GetUserUsecase implements IGetUserUsecase {
  GetUserUsecase({required IAuthRepository repository})
      : _repository = repository;

  final IAuthRepository _repository;

  @override
  Future<(UserEntity?, BaseException?)> call() async {
    return await _repository.getUser();
  }
}
