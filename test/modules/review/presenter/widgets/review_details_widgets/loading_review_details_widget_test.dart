import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/review/presenter/widgets/review_details_widgets/loading_review_details_widget.dart';

void main() {
  group('loading review details widget tests', () {
    testWidgets('should render widget correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoadingReviewDetailsWidget()),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
