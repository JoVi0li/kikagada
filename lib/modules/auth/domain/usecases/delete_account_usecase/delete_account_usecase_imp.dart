
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/errors/auth_errors.dart';
import 'package:kikagada/modules/auth/domain/repositories/auth_repository.dart';
import 'package:kikagada/modules/auth/domain/usecases/delete_account_usecase/delete_account_usecase.dart';

final class DeleteAccountUsecase implements IDeleteAccountUsecase {
  DeleteAccountUsecase({required IAuthRepository repository})
      : _repository = repository;

  final IAuthRepository _repository;

  @override
  Future<(UserEntity?, AuthError?)> call() async {
    return await _repository.deleteAccount();
  }
}
