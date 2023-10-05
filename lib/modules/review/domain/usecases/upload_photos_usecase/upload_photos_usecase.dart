import 'package:kikagada/modules/review/domain/errors/review_errors.dart';
import 'package:kikagada/modules/review/domain/repositories/review_repository.dart';

abstract interface class IUploadPhotosUsecase {
  Future<(List<String>? success, ReviewError? error)> call(List<String> photos);
}

final class UploadPhotosUsecase implements IUploadPhotosUsecase {
  UploadPhotosUsecase({required IReviewRepository repository})
      : _repository = repository;
  final IReviewRepository _repository;

  @override
  Future<(List<String>?, ReviewError?)> call(List<String> photos) async {
    return await _repository.uploadPhotos(photos);
  }
}
