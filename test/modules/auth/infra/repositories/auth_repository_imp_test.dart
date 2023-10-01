import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/errors/auth_errors.dart';
import 'package:kikagada/modules/auth/domain/repositories/auth_repository.dart';
import 'package:kikagada/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:kikagada/modules/auth/infra/repositories/auth_repository_imp.dart';
import 'package:mocktail/mocktail.dart';

class AuthDatasourceMock extends Mock implements AuthDatasource {}

void main() {
  late AuthRepository authRepository;
  late AuthDatasource authDatasource;
  late UserEntity userEntity;
  late AuthError authError;

  setUp(() {
    authDatasource = AuthDatasourceMock();
    authRepository = AuthRepositoryImp(datasource: authDatasource);
    userEntity = UserEntity(
      id: '0',
      name: 'João',
      email: 'joao@gmail.com',
      photo: null,
    );
    authError = GenericAuthError(error: 'test', message: null);
  });

  group('auth repository imp tests', () {
    test('should return an UserEntity instance', () async {
      when(() => authDatasource.loginWithGoogle()).thenAnswer(
        (_) => Future(() => userEntity),
      );

      final (user, error) = await authRepository.loginWithGoogle();

      verify(() => authRepository.loginWithGoogle()).called(1);

      expect(error, null);
      expect(user, isA<UserEntity>());
      expect(user!.email, 'joao@gmail.com');
    });

    test('should return an AuthError instance', () async {
      when(() => authDatasource.loginWithGoogle()).thenThrow(authError);

      final (user, error) = await authRepository.loginWithGoogle();

      verify(() => authRepository.loginWithGoogle()).called(1);

      expect(user, null);
      expect(error, isA<GenericAuthError>());
      expect(error!.message, null);
    });
  });
}
