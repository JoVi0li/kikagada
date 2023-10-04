import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';

class CreateReviewController {
  CreateReviewController() {
    initController();
  }

  late final TextEditingController titleController;
  late final TextEditingController bodyController;
  late List<File> photos;

  void initController() {
    titleController = TextEditingController();
    bodyController = TextEditingController();
    photos = [];
  }

  void disposeController() {
    titleController.dispose();
    bodyController.dispose();
  }

  Future<(List<File>? photos, ReviewError? error)> pickPhotos(
    BuildContext context,
  ) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
        allowedExtensions: ['png', 'jpg', 'jpeg'],
      );

      if (result?.count != null && result!.count > 3) {
        return (
          null,
          GenericReviewError(
            error: 'Número máximo de imagens excedido',
            message: 'Selecione no máximo 3 imagens',
          ),
        );
      }

      if (photos.isNotEmpty) {
        photos = [];
      }

      for (int index = 0; index < result!.count; index++) {
        photos.add(File(result.files[index].path!));
      }

      return (photos, null);
    } catch (e) {
      return (
        null,
        GenericReviewError(
          error: 'Ops! Algo deu errado',
          message: e.toString(),
        ),
      );
    }
  }
}
