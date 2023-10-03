import 'package:kikagada/modules/review/domain/errors/review_errors.dart';
import 'package:kikagada/modules/review/domain/repositories/review_repository.dart';

abstract interface class IGetPhotosDownloadURL {
  Future<(List<String>? success, ReviewError? error)> call(
      List<String> photosPath);
}

class GetPhotosDownloadURL implements IGetPhotosDownloadURL {
  GetPhotosDownloadURL({required IReviewRepository repository})
      : _repository = repository;

  final IReviewRepository _repository;

  @override
  Future<(List<String>?, ReviewError?)> call(List<String> photosPath) async {
    return await _repository.getPhotosDownloadURL(photosPath);
  }
}
