import 'package:kikagada/modules/review/domain/repositories/review_repository.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';

abstract interface class IUploadPhotosUsecase {
  Future<(List<String>? success, BaseException? error)> call(
      List<String> photos);
}

final class UploadPhotosUsecase implements IUploadPhotosUsecase {
  UploadPhotosUsecase({required IReviewRepository repository})
      : _repository = repository;
  final IReviewRepository _repository;

  @override
  Future<(List<String>?, BaseException?)> call(List<String> photos) async {
    return await _repository.uploadPhotos(photos);
  }
}
