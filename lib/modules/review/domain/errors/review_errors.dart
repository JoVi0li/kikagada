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

class GenericFirestoreReviewError extends ReviewError {
  GenericFirestoreReviewError({
    required super.error,
    required super.message,
  });
}
