import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/repositories/auth_repository.dart';
import 'package:kikagada/modules/auth/domain/usecases/delete_account_usecase/delete_account_usecase.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';

final class DeleteAccountUsecase implements IDeleteAccountUsecase {
  DeleteAccountUsecase({required IAuthRepository repository})
      : _repository = repository;

  final IAuthRepository _repository;

  @override
  Future<(UserEntity?, BaseException?)> call() async {
    return await _repository.deleteAccount();
  }
}
