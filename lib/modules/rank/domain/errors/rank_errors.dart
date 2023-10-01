abstract class RankError {
  final String error;
  final String? message;
  final StackTrace? trace;

  RankError({
    required this.error,
    this.message,
    this.trace,
  }) : assert(error.isNotEmpty, 'error property can not be empty');
}

class GenericRankError extends RankError {
  GenericRankError({
    required super.error,
    super.message,
    super.trace,
  }) : assert(error.isNotEmpty, 'error property can not be empty');
}

class FirebaseRankError extends RankError {
  FirebaseRankError({
    required super.error,
    super.message,
    super.trace,
  }) : assert(error.isNotEmpty, 'error property can not be empty');
}
