import 'package:flutter/material.dart';

class GalleryViewComponent extends StatelessWidget {
  GalleryViewComponent({super.key, required this.photosURL})
      : assert(photosURL.isNotEmpty, 'photosURL can not be empty');

  final List<String> photosURL;

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
            style: Theme.of(context).textTheme.labelLarge,
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
        return Image.network(
          photosURL[index],
          fit: BoxFit.fill,
          filterQuality: FilterQuality.low,
          width: photosURL.length > 1
              ? getSize(ctx).width * 0.97
              : getSize(ctx).width,
          height: getSize(ctx).height * 0.25,
          cacheWidth: getSize(ctx).width.toInt(),
          cacheHeight: (getSize(ctx).height * 0.25).toInt(),
          frameBuilder: frameBuilder,
          errorBuilder: errorBuilder,
        );
      },
    );
  }
}
