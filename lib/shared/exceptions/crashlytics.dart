import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
/// TODO: refactor and implement a class to create exceptions and record them to crashlytics
abstract interface class ICrashlytics {
  Future<void> recordError(Exception e, StackTrace s, dynamic reason);
  Future<void> recordFlutterError(FlutterErrorDetails flutterErrorDetails);
}

class FirebaseCrashlyticsImp implements ICrashlytics {
  final FirebaseCrashlytics _crashlytics;

  FirebaseCrashlyticsImp(this._crashlytics);

  @override
  Future<void> recordError(Exception e, StackTrace s, dynamic reason) async {
    return await _crashlytics.recordError(e, s, reason: reason);
  }

  @override
  Future<void> recordFlutterError(
    FlutterErrorDetails flutterErrorDetails,
  ) async {
    return await _crashlytics.recordFlutterError(flutterErrorDetails);
  }
}
