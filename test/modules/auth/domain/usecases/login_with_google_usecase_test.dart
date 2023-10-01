import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/errors/auth_errors.dart';
import 'package:kikagada/modules/auth/domain/repositories/auth_repository.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:mocktail/mocktail.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

void main() {
  late AuthRepository authRepository;
  late LoginWithGoogleUsecase loginWithGoogleUsecase;
  late UserEntity userEntity;
  late AuthError authError;

  setUp(() {
    authRepository = AuthRepositoryMock();
    loginWithGoogleUsecase = LoginWithGoogleUsecaseImp(
      repository: authRepository,
    );
    userEntity = UserEntity(
      id: '0',
      name: 'João',
      email: 'joao@gmail.com',
      photo: null,
    );
    authError = GenericFirebaseAuthError(error: 'test', message: null);
  });

  group('login with google usecase tests', () {
    test('should return an UserEntity instance', () async {
      when(() => authRepository.loginWithGoogle())
          .thenAnswer((_) => Future(() => (userEntity, null)));

      final (user, error) = await loginWithGoogleUsecase();

      expect(error, null);
      expect(user, isA<UserEntity>());
      expect(user!.email, userEntity.email);
    });

    test('should return a AuthError instance', () async {
      when(() => authRepository.loginWithGoogle())
          .thenAnswer((_) => Future(() => (null, authError)));

      final (user, error) = await loginWithGoogleUsecase();

      expect(user, null);
      expect(error, isA<AuthError>());
      expect(error!.error, 'test');
    });
  });
}
