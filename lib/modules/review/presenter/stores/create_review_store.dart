import 'package:flutter/material.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';
import 'package:kikagada/modules/review/domain/usecases/create_review_usecase/create_review_usecase.dart';
import 'package:kikagada/modules/review/domain/usecases/upload_photos_usecase/upload_photos_usecase.dart';
import 'package:kikagada/modules/review/presenter/states/create_review_state.dart';

final class CreateReviewStore extends ValueNotifier<CreateReviewState> {
  CreateReviewStore(this.createReviewUsecase, this.uploadPhotosUsecase)
      : super(CreateReviewInitialState()) {
    initStore();
  }

  late final GlobalKey<FormState> formKey;
  late final TextEditingController titleController;
  late final TextEditingController bodyController;
  late List<String> photosPath;

  final ICreateReviewUsecase createReviewUsecase;
  final IUploadPhotosUsecase uploadPhotosUsecase;

  void initStore() {
    formKey = GlobalKey<FormState>();
    titleController = TextEditingController();
    bodyController = TextEditingController();
    photosPath = [];
  }

  void disposeStore() {
    titleController.dispose();
    bodyController.dispose();
  }

  void resetValues() {
    titleController.text = '';
    bodyController.text = '';
    photosPath = [];
  }

  Future<void> createReview() async {
    final hasPhoto = photosValidator();

    if (!hasPhoto) {
      value = CreateReviewHasNoPhotosState();
      return;
    }

    if (!(formKey.currentState!.validate())) return;

    value = CreateReviewLoadingState();

    final (photos, uploadFailure) = await uploadPhotosUsecase(photosPath);

    if (uploadFailure != null) {
      value = CreateReviewErrorState(error: uploadFailure);
      return;
    }

    final currentDateTime = DateTime.now();

    final review = ReviewEntity(
      id: '',
      authorId: '',
      createdAt: currentDateTime,
      updatedAt: currentDateTime,
      title: titleController.text,
      body: bodyController.text,
      photos: photos!,
    );

    final (success, failure) = await createReviewUsecase(review);

    if (failure != null) {
      value = CreateReviewErrorState(error: failure);
      return;
    }

    if (success != null) {
      value = CreateReviewSuccessState(review: success);
      return;
    }
  }

  void getImagesPath(List<String> paths) {
    if (paths.isNotEmpty) {
      photosPath = paths;
    }
  }

  Future<void> onErrorGettingImage(ReviewError error) async {
    value = CreateReviewErrorState(error: error);
  }

  bool photosValidator() {
    if (photosPath.isEmpty) return false;
    return true;
  }

  String? titleValidator(String? value) {
    if (value == null || value.isEmpty) return 'Informe um título';
    if (value.length < 3) return 'Título muito curto';
    return null;
  }

  String? bodyValidator(String? value) {
    if (value == null || value.isEmpty) return 'Informe suas observações';
    if (value.length < 10) return 'Observação muito curta';
    return null;
  }
}
