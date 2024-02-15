import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/repositories/auth_repository.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_google_usecase/login_with_google_usecase.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_google_usecase/login_with_google_usecase_imp.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';
import 'package:mocktail/mocktail.dart';

class AuthRepositoryMock extends Mock implements IAuthRepository {}

void main() {
  late final ILoginWithGoogleUsecase usecase;
  late final IAuthRepository repository;
  late final UserEntity entity;
  late final BaseException error;

  setUpAll(() {
    repository = AuthRepositoryMock();
    usecase = LoginWithGoogleUsecaseImp(repository: repository);
    entity = UserEntity(
      id: '01',
      name: 'João Vitor',
      email: 'joao@gmail.com',
      photo: null,
    );
    error = BaseException.basicException(exception: Exception(), stackTrace: StackTrace.fromString(""));
  });

  group('login with google usecase imp tests', () {
    test('should return a success value', () async {
      when(() => repository.loginWithGoogle()).thenAnswer(
        (_) => Future.value((entity, null)),
      );

      final (success, failure) = await usecase();

      expect(failure, isNull);
      expect(success, isA<UserEntity>());
    });

    test('should return a failure value', () async {
      when(() => repository.loginWithGoogle()).thenAnswer(
        (_) => Future.value((null, error)),
      );

      final (success, failure) = await usecase();

      expect(success, isNull);
      expect(failure, isA<BaseException>());
    });
  });
}
