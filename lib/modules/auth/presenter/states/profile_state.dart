import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/errors/auth_errors.dart';

abstract base class ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileRetrievedAccountState extends ProfileState {
  ProfileRetrievedAccountState({required this.user});
  final UserEntity user;
}

final class ProfileDeletedAccountState extends ProfileState {
  ProfileDeletedAccountState({required this.deletedAccount});
  final UserEntity deletedAccount;
}

final class ProfileInitDeleteAccountFlowState extends ProfileState {
  ProfileInitDeleteAccountFlowState({required this.user});
  final UserEntity user;
}

final class ProfileErrorState extends ProfileState {
  ProfileErrorState({required this.error});
  final AuthError error;
}
