import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:kikagada/shared/exceptions/base_exception.dart';
import 'package:kikagada/modules/review/presenter/components/gallery_view_component.dart';
import 'package:kikagada/modules/review/presenter/stores/create_review_store.dart';
import 'package:kikagada/shared/components/button_component.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateReviewInitialWidget extends StatefulWidget {
  const CreateReviewInitialWidget({
    super.key,
  });
  @override
  State<CreateReviewInitialWidget> createState() =>
      _CreateReviewInitialWidgetState();
}

class _CreateReviewInitialWidgetState extends State<CreateReviewInitialWidget> {
  late final GetIt _getIt;
  late final FilePicker picker;
  late final CreateReviewStore _store;

  Future<void> pickImages() async {
    try {
      await handleRequestPermissions();

      final result =
          await picker.pickFiles(type: FileType.image, allowMultiple: true);

      if (result == null || result.count == 0) return;

      if (result.count > 3) {
        throw BaseException.basicException(
          exception: Exception('Selecione no máximo 3 fotos'),
          message: 'Tente novamente e respeito o limite',
        );
      }

      final paths = result.files.map((file) => file.path!).toList();

      _store.getImagesPath(paths);
      setState(() {});
    } on BaseException catch (e) {
      _store.onErrorGettingImage(e);
    } catch (e) {
      _store.onErrorGettingImage(
        BaseException.basicException(
          exception: Exception(
            'Não foi possível selecionar as fotos. Tente novamente',
          ),
          message: null,
        ),
      );
    }
  }

  Future<void> handleRequestPermissions() async {
    final status = await Permission.accessMediaLocation.status;

    if (status == PermissionStatus.denied) {
      await Permission.accessMediaLocation.request();
    }
  }

  @override
  void initState() {
    super.initState();
    _getIt = GetIt.I;
    picker = FilePicker.platform;
    _store = _getIt<CreateReviewStore>();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: _store.formKey,
          child: Column(
            children: [
              Ink(
                height: MediaQuery.sizeOf(context).height * 0.30,
                width: MediaQuery.sizeOf(context).width - 48,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: InkWell(
                  onTap: pickImages,
                  child: _store.photosPath.isEmpty
                      ? SvgPicture.asset(
                          'lib/shared/assets/icons/fileupload.svg',
                          fit: BoxFit.none,
                          height: 24,
                          width: 24,
                        )
                      : GalleryViewComponent(
                          isFromAssets: true,
                          photosURL: _store.photosPath,
                        ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: MediaQuery.sizeOf(context).width - 48,
                height: MediaQuery.sizeOf(context).height * 0.40,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        style: Theme.of(context).textTheme.titleSmall,
                        controller: _store.titleController,
                        validator: _store.titleValidator,
                        maxLines: 1,
                        maxLength: 100,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Adicione um título...',
                        ),
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.labelMedium,
                        controller: _store.bodyController,
                        validator: _store.bodyValidator,
                        maxLines: null,
                        maxLength: 1000,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Escreva aqui sua review...',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 48,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ButtonComponent(
                        onPressed: _store.createReview,
                        label: 'Criar',
                        type: ButtonComponentType.create,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
