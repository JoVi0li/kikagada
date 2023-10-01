import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/review/domain/errors/review_errors.dart';
import 'package:kikagada/modules/review/presenter/widgets/review_details_widgets/error_review_details_widget.dart';

void main() {
  late final ReviewError error;

  setUpAll(() {
    error = GenericReviewError(
      error: 'Erro',
      message: 'Message',
    );
  });
  group('error review details widget tests', () {
    testWidgets('should render widget correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: ErrorReviewDetailsWidget(error: error)),
      );

      expect(find.byIcon(Icons.error), findsOneWidget);
      expect(find.text(error.error), findsOneWidget);
    });
  });
}
