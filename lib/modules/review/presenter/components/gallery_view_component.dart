import 'dart:io';

import 'package:flutter/material.dart';

class GalleryViewComponent extends StatelessWidget {
  GalleryViewComponent({
    super.key,
    required this.photosURL,
    this.isFromAssets = false,
  }) : assert(photosURL.isNotEmpty, 'photosURL can not be empty');

  final List<String> photosURL;
  final bool isFromAssets;

  Widget frameBuilder(
    BuildContext context,
    Widget child,
    int? frame,
    bool wasSynchronouslyLoaded,
  ) {
    if (wasSynchronouslyLoaded) {
      return child;
    }
    return AnimatedOpacity(
      opacity: frame == null ? 0 : 1,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOut,
      child: child,
    );
  }

  Widget errorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return SizedBox(
      width: getSize(context).width,
      height: getSize(context).height * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.white, size: 36),
          const SizedBox(height: 24),
          Text(
            'Não foi possivel carregar a imagem',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }

  Size getSize(BuildContext context) {
    return MediaQuery.sizeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: photosURL.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext ctx, int index) {
        return Container(
          width: getSize(ctx).width,
          height: getSize(ctx).height,
          margin: photosURL.length == 1
              ? null
              : const EdgeInsets.only(right: 24, left: 24),
          padding: photosURL.length == 1
              ? const EdgeInsets.only(right: 24, left: 24)
              : null,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: isFromAssets  ? Image.file(
              File(photosURL[index]),
              fit: BoxFit.fill,
              filterQuality: FilterQuality.low,
              cacheWidth: getSize(ctx).width.toInt(),
              cacheHeight: (getSize(ctx).height * 0.25).toInt(),
              frameBuilder: frameBuilder,
              errorBuilder: errorBuilder,
            ) : Image.network(
              photosURL[index],
              fit: BoxFit.fill,
              filterQuality: FilterQuality.low,
              cacheWidth: getSize(ctx).width.toInt(),
              cacheHeight: (getSize(ctx).height * 0.25).toInt(),
              frameBuilder: frameBuilder,
              errorBuilder: errorBuilder,
            ),
          ),
        );
      },
    );
  }
}
