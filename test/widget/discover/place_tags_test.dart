import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wheelmap/presentation/discover/place_tags.dart';

import '../../test_utils/widget_test_utility.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(
    'Place tags item',
    () {
      testWidgets(
        'List is visible',
        (WidgetTester tester) async {
          /// Arrange
          var sut = wrapWidgetForTesting(PlaceTags(
            tags: const ['A', 'B', 'C'],
          ));
          await tester.pumpWidget(sut);
          await tester.pumpAndSettle();

          /// Act
          final placeFinder = find.byType(PlaceTag);

          /// Assert
          expect(placeFinder, findsNWidgets(3));
        },
      );
    },
  );

  group(
    'Place tag item',
    () {
      testWidgets(
        'item is visible',
        (WidgetTester tester) async {
          /// Arrange
          var sut = wrapWidgetForTesting(PlaceTag(
            placeTagText: 'A',
          ));
          await tester.pumpWidget(sut);
          await tester.pumpAndSettle();

          /// Act
          final circleAvatarFinder = find.byType(CircleAvatar);
          final iconFinder = find.byIcon(Icons.place);
          final textFinder = find.text('A');

          /// Assert
          expect(circleAvatarFinder, findsOneWidget);
          expect(iconFinder, findsOneWidget);
          expect(textFinder, findsOneWidget);
        },
      );
    },
  );
}
