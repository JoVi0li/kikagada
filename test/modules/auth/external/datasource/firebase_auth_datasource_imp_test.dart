import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/external/datasource/firebase_auth_datasource_imp.dart';
import 'package:mocktail/mocktail.dart';

class FirebaseAuthDatasourceImpMock extends Mock
    implements FirebaseAuthDatasourceImp {}

void main() {
  late FirebaseAuthDatasourceImpMock firebaseAuthDatasource;

  setUp(() {
    firebaseAuthDatasource = FirebaseAuthDatasourceImpMock();
  });

  group('firebase_auth_datasource_imp_test', () {
    test('should return an UserEntity instance', () async {
      when(() => firebaseAuthDatasource.loginWithGoogle()).thenAnswer(
        (_) => Future(
          () => UserEntity(
            id: '02',
            name: 'João',
            email: 'joao.silva@gmail.com',
            photo: null,
          ),
        ),
      );

      final result = await firebaseAuthDatasource.loginWithGoogle();

      verify(() => firebaseAuthDatasource.loginWithGoogle()).called(1);
      expect(result.email, 'joao.silva@gmail.com');
    });
  });
}
