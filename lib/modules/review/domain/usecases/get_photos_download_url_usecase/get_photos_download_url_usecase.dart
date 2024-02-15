import 'package:kikagada/modules/review/domain/repositories/review_repository.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';

abstract interface class IGetPhotosDownloadURL {
  Future<(List<String>? success, BaseException? error)> call(
      List<String> photosPath);
}

class GetPhotosDownloadURL implements IGetPhotosDownloadURL {
  GetPhotosDownloadURL({required IReviewRepository repository})
      : _repository = repository;

  final IReviewRepository _repository;

  @override
  Future<(List<String>?, BaseException?)> call(List<String> photosPath) async {
    return await _repository.getPhotosDownloadURL(photosPath);
  }
}
