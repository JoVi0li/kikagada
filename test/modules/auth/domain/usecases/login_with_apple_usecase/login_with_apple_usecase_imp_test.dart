import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/errors/auth_errors.dart';
import 'package:kikagada/modules/auth/domain/repositories/auth_repository.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_apple_usecase/login_with_apple_usecase.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_apple_usecase/login_with_apple_usecase_imp.dart';
import 'package:mocktail/mocktail.dart';

class AuthRepositoryMock extends Mock implements IAuthRepository {}

void main() {
  late final ILoginWithAppleUsecase usecase;
  late final IAuthRepository repository;
  late final UserEntity entity;
  late final AuthError error;

  setUpAll(() {
    repository = AuthRepositoryMock();
    usecase = LoginWithAppleUsecaseImp(repository: repository);
    entity = UserEntity(
      id: '01',
      name: 'João Vitor',
      email: 'joao@gmail.com',
      photo: null,
    );
    error = GenericAuthError(error: 'Error');
  });

  group('login with apple usecase imp tests', () {
    test('should return a success value', () async {
      when(() => repository.loginWithApple()).thenAnswer(
        (_) => Future.value((entity, null)),
      );

      final (success, failure) = await usecase();

      expect(failure, isNull);
      expect(success, isA<UserEntity>());
    });

    test('should return a failure value', () async {
      when(() => repository.loginWithApple()).thenAnswer(
        (_) => Future.value((null, error)),
      );

      final (success, failure) = await usecase();

      expect(success, isNull);
      expect(failure, isA<AuthError>());
    });
  });
}
