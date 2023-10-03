import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/presenter/components/gallery_view_component.dart';
import 'package:kikagada/modules/review/presenter/widgets/review_details_widgets/success_review_details_widget.dart';

void main() {
  late final ReviewEntity review;

  setUpAll(() {
    review = ReviewEntity(
      id: "01",
      authorId: "01",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      title: "Post 01",
      body:
          "Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt, explicabo. Nemo enim ipsam voluptatem, quia voluptas sit, aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos, qui ratione voluptatem sequi nesciunt, neque porro quisquam est, qui dolorem ipsum, quia dolor sit amet consectetur adipisci[ng] velit, sed quia non numquam [do] eius modi tempora inci[di]dunt, ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum[d] exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? [D]Quis autem vel eum i[r]ure reprehenderit, qui in ea voluptate velit esse, quam nihil molestiae consequatur, vel illum, qui dolorem eum fugiat, quo voluptas nulla pariatur?",
      photos: [
        "https://avatars.githubusercontent.com/u/73193391?s=400&u=8da09a4f340724a510176361c6835f5f1aaef57c&v=4"
      ],
    );
  });
  group('success review details widget tests', () {
    testWidgets('should render widget correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: SuccessReviewDetailsWidget(review: review)),
      );

      expect(find.text(review.title), findsOneWidget);
      expect(find.text(review.body), findsOneWidget);
      expect(find.byType(GalleryViewComponent), findsOneWidget);
    });
  });
}
