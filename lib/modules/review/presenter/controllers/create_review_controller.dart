import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';
import 'package:permission_handler/permission_handler.dart';

abstract interface class ICreateReviewController {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController titleController;
  late final TextEditingController bodyController;
  late List<File> photos;
  void initController();
  void disposeController();
  Future<(List<File>? photos, ReviewError? error)> pickPhotos(
    BuildContext context,
  );
  String? validator(String field, String? value);
  Future<bool> photosValidator(BuildContext context);
}

class CreateReviewController implements ICreateReviewController {
  CreateReviewController();

  @override
  late GlobalKey<FormState> formKey;
  @override
  late final TextEditingController titleController;
  @override
  late final TextEditingController bodyController;
  @override
  late List<File> photos;

  @override
  void initController() {
    formKey = GlobalKey<FormState>();
    titleController = TextEditingController();
    bodyController = TextEditingController();
    photos = [];
  }

  @override
  void disposeController() {
    titleController.dispose();
    bodyController.dispose();
  }

  @override
  Future<(List<File>? photos, ReviewError? error)> pickPhotos(
    BuildContext context,
  ) async {
    while (await Permission.photos.status == PermissionStatus.denied) {
      await askPermissionToAccessPhoto();
    }
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
      );

      if (result == null) {
        return (photos, null);
      }

      if (result.count > 3) {
        return (
          null,
          GenericReviewError(
            error: 'Selecione no máximo 3 imagens',
            message: null,
          ),
        );
      }

      if (photos.isNotEmpty) {
        photos = [];
      }

      for (int index = 0; index < result.count; index++) {
        photos.add(File(result.files[index].path!));
      }

      return (photos, null);
    } catch (e) {
      return (
        null,
        GenericReviewError(
          error: e.toString(),
          message: null,
        ),
      );
    }
  }

  Future<PermissionStatus> askPermissionToAccessPhoto() async {
    return await Permission.photos.request();
  }

  @override
  String? validator(String field, String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe um $field para sua review';
    }

    if (value.length < 3) {
      return 'O $field precisa de ao menos 3 caracteres';
    }

    return null;
  }

  @override
  Future<bool> photosValidator(BuildContext context) async {
    if (photos.isEmpty) {
      /// TODO: implement error dialog
      return false;
    }

    return true;
  }
}
