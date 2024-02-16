import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/auth/presenter/states/login_state.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';

void main() {
  late final BaseException error;

  setUpAll(() {
    error = BaseException.basicException(exception: Exception(), stackTrace: StackTrace.fromString(""));
  });

  group('login state tests', () {
    test('LoginInitialState should be a subclass of LoginState', () {
      expect(LoginInitialState(), isA<LoginState>());
    });

    test('LoginLoadingState should be a subclass of LoginState', () {
      expect(LoginLoadingState(), isA<LoginState>());
    });

    test('LoginSuccessState should be a subclass of LoginState', () {
      expect(LoginSuccessState(), isA<LoginState>());
    });

    test('LoginErrorState should be a subclass of LoginState', () {
      expect(LoginErrorState(exception: error), isA<LoginState>());
    });
  });
}
