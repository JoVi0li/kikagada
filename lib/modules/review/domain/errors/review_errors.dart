abstract class ReviewError {
  final String error;
  final String? message;

  ReviewError({
    required this.error,
    required this.message,
  });
}

class GenericReviewError extends ReviewError {
  GenericReviewError({
    required super.error,
    required super.message,
  });
}

class GenericFirebaseReviewError extends ReviewError {
  GenericFirebaseReviewError({
    required super.error,
    required super.message,
  });
}
