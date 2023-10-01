import 'package:flutter/material.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/presenter/components/gallery_view_component.dart';

class SuccessReviewDetailsWidget extends StatefulWidget {
  const SuccessReviewDetailsWidget({super.key, required this.review});
  final ReviewEntity review;

  @override
  State<SuccessReviewDetailsWidget> createState() =>
      _SuccessReviewDetailsWidgetState();
}

class _SuccessReviewDetailsWidgetState
    extends State<SuccessReviewDetailsWidget> {
  late bool isFullTextVisible;

  @override
  void initState() {
    super.initState();
    isFullTextVisible = false;
  }

  void changeTextVisibility() {
    setState(() {
      isFullTextVisible = !isFullTextVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.35,
            child: GalleryViewComponent(photosURL: widget.review.photos),
          ),
          const SizedBox(height: 36),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              widget.review.title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GestureDetector(
              onTap: changeTextVisibility,
              child: Text(
                widget.review.body,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
                textAlign: TextAlign.left,
                maxLines: isFullTextVisible ? null : 5,
                overflow: isFullTextVisible ? null : TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
