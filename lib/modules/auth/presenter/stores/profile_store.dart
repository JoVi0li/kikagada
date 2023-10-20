import 'package:flutter/foundation.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/usecases/delete_account_usecase/delete_account_usecase.dart';
import 'package:kikagada/modules/auth/domain/usecases/get_user_usecase/get_user_usecase.dart';
import 'package:kikagada/modules/auth/presenter/states/profile_state.dart';

abstract interface class IProfileStore extends ValueListenable<ProfileState> {
  Future<void> getUser();
  Future<void> deleteAccount();
  void initDeleteAccountFlow(UserEntity user);
  void cancelDeleteAccountFlow(UserEntity user);
}

class ProfileStore extends ValueNotifier<ProfileState>
    implements IProfileStore {
  ProfileStore(this.getUserUsecase, this.deleteAccountUsecase)
      : super(ProfileLoadingState()) {
    getUser();
  }

  final IGetUserUsecase getUserUsecase;
  final IDeleteAccountUsecase deleteAccountUsecase;

  @override
  Future<void> deleteAccount() async {
    final (deletedAccount, error) = await deleteAccountUsecase();

    if (error != null) {
      value = ProfileErrorState(error: error);
      return;
    }

    if (deletedAccount != null) {
      value = ProfileDeletedAccountState(deletedAccount: deletedAccount);
    }
  }

  @override
  Future<void> getUser() async {
    final (user, error) = await getUserUsecase();

    if (error != null) {
      value = ProfileErrorState(error: error);
      return;
    }

    if (user != null) {
      value = ProfileRetrievedAccountState(user: user);
      return;
    }
  }

  @override
  void initDeleteAccountFlow(UserEntity user) {
    value = ProfileInitDeleteAccountFlowState(user: user);
  }

  @override
  void cancelDeleteAccountFlow(UserEntity user) {
    value = ProfileRetrievedAccountState(user: user);
  }
}
