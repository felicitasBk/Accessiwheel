import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wheelmap/presentation/common_widgets/subtitle_row.dart';
import 'package:wheelmap/presentation/common_widgets/text_widgets.dart';

import '../../test_utils/widget_test_utility.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(
    'Subtitle row item',
    () {
      testWidgets(
        'Is present ',
        (WidgetTester tester) async {
          /// Arrange
          var sut = wrapWidgetForTesting(
            SubtitleRow(
              text: 'A',
            ),
          );
          await tester.pumpWidget(sut);
          await tester.pumpAndSettle();

          /// Act
          final rowFinder = find.byType(Row);
          final subtitleFinder = find.byType(SubtitleText);
          final buttonFinder = find.byType(TextButton);
          final iconFinder = find.byIcon(Icons.arrow_forward_ios);
          final labelFinder = find.byType(TextButtonLabel);
          /// Assert
          expect(rowFinder, findsNWidgets(2));
          expect(subtitleFinder, findsOneWidget);
          expect(buttonFinder, findsOneWidget);
          expect(iconFinder, findsOneWidget);
          expect(labelFinder, findsOneWidget);
        },
      );
    },
  );
}
