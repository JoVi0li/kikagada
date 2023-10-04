import 'package:flutter/material.dart';
import 'package:kikagada/modules/review/presenter/controllers/create_review_controller.dart';
import 'package:kikagada/shared/components/app_bar_component.dart';
import 'package:kikagada/shared/components/error_dialog_component.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  late final ICreateReviewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CreateReviewController();
    _controller.initController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.disposeController();
  }

  Future<void> pickImages(BuildContext context) async {
    final (_, error) = await _controller.pickPhotos(context);

    setState(() {});

    if (error != null) {
      showDialog(
        context: context,
        builder: (ctx) => ErrorDialogComponent(errorMessage: error.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.sizeOf(context).width, 60),
        child: const AppBarComponent(
          title: 'Criar review',
          hasBackButton: true,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _controller.titleController,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
                maxLength: 50,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Título',
                ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _controller.bodyController,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
                maxLines: 10,
                maxLength: 1200,
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
                    const Icon(
                      Icons.upload,
                      color: Colors.white,
                    ),
                    Text(
                      'Subir fotos',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _controller.photos.length,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                        title: Text(_controller.photos[index].path));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
