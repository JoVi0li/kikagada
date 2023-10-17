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

class _SuccessReviewDetailsWidgetState extends State<SuccessReviewDetailsWidget> {
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
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF020202), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            margin: const EdgeInsets.only(left: 24, right: 24),
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.review.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: SingleChildScrollView(
                      child: Text(
                        widget.review.body,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
