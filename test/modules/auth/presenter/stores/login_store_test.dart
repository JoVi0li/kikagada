import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_apple_usecase/login_with_apple_usecase.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_google_usecase/login_with_google_usecase.dart';
import 'package:kikagada/modules/auth/presenter/states/login_state.dart';
import 'package:kikagada/modules/auth/presenter/stores/login_store.dart';
import 'package:mocktail/mocktail.dart';

class LoginWithAppleUsecaseMock extends Mock
    implements ILoginWithAppleUsecase {}

class LoginWithGoogleUsecaseMock extends Mock
    implements ILoginWithGoogleUsecase {}

/// TODO: Refactor tests
void main() {
  late final LoginStore store;
  late final ILoginWithAppleUsecase loginWithAppleUsecase;
  late final ILoginWithGoogleUsecase loginWithGoogleUsecase;
  late final UserEntity entity;

  setUpAll(() {
    loginWithAppleUsecase = LoginWithAppleUsecaseMock();
    loginWithGoogleUsecase = LoginWithGoogleUsecaseMock();
    entity = UserEntity(
      id: '01',
      name: 'João Vitor',
      email: 'joao@gmail.com',
      photo: null,
    );
    store = LoginStore(loginWithGoogleUsecase, loginWithAppleUsecase);
  });

  group('login store tests', () {
    test('should return initial state on create store', () {
      expect(store.value, isA<LoginInitialState>());
    });

    test('should return loading state on execute loginWithApple method',
        () async {
      when(() => loginWithAppleUsecase()).thenAnswer(
        (_) => Future.value((entity, null)),
      );

      final loginWithApple = store.login();

      expect(store.value, isA<LoginLoadingState>());

      await loginWithApple;
    });

    test('should return loading state on execute loginWithGoogle method',
        () async {
      when(() => loginWithGoogleUsecase()).thenAnswer(
        (_) => Future.value((entity, null)),
      );

      final loginWithGoogle = store.login();

      expect(store.value, isA<LoginLoadingState>());

      await loginWithGoogle;
    });

    test('should return success state after execute loginWithApple method',
        () async {
      when(() => loginWithAppleUsecase()).thenAnswer(
        (_) => Future.value((entity, null)),
      );

      await store.login();

      expect(store.value, isA<LoginSuccessState>());
    });

    test('should return success state after execute loginWithGoogle method',
        () async {
      when(() => loginWithGoogleUsecase()).thenAnswer(
        (_) => Future.value((entity, null)),
      );

      await store.login();

      expect(store.value, isA<LoginSuccessState>());
    });
  });
}
