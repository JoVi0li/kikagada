import 'package:flutter/material.dart';
import 'package:kikagada/modules/review/presenter/components/selected_files_preview_component.dart';
import 'package:kikagada/modules/review/presenter/controllers/create_review_controller.dart';

class CreateReviewInitialWidget extends StatefulWidget {
  const CreateReviewInitialWidget(this._controller,
      {super.key, required this.onPressed});

  final ICreateReviewController _controller;

  final void Function() onPressed;

  @override
  State<CreateReviewInitialWidget> createState() =>
      _CreateReviewInitialWidgetState();
}

class _CreateReviewInitialWidgetState extends State<CreateReviewInitialWidget> {
  Future<void> pickImages(BuildContext context) async {
    final (_, error) = await widget._controller.pickPhotos(context);

    setState(() {});

    if (error != null) {
      /// TODO: implement error dialog 
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: widget._controller.formKey,
        child: Column(
          children: [
            TextFormField(
              maxLines: 1,
              maxLength: 50,
              controller: widget._controller.titleController,
              validator: (value) =>
                  widget._controller.validator('título', value),
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Título',
              ),
            ),
            const SizedBox(height: 32),
            TextFormField(
              maxLines: 10,
              maxLength: 1200,
              controller: widget._controller.bodyController,
              validator: (value) =>
                  widget._controller.validator('relato', value),
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Relato',
              ),
            ),
            const SizedBox(height: 32),
            TextButton(
              onPressed: () async => await pickImages(context),
              child: Row(
                children: [
                  const Icon(Icons.upload, color: Colors.white),
                  const SizedBox(width: 12),
                  Text(
                    'Subir fotos',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            SelectedFilesPreviewComponent(files: widget._controller.photos),
            const SizedBox(height: 32),
            OutlinedButton(
              onPressed: () async {
                if (!await (widget._controller.photosValidator(context))) {
                  return;
                }

                widget.onPressed();
              },
              child: const Text('Criar review'),
            ),
          ],
        ),
      ),
    );
  }
}
