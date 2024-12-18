import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wheelmap/common/constants/app_image_paths.dart';
import 'package:wheelmap/presentation/common_widgets/square_route_card.dart';
import 'package:wheelmap/presentation/common_widgets/text_widgets.dart';
import 'package:wheelmap/presentation/discover/recommended_route.dart';
import 'package:wheelmap/presentation/discover/recommended_routes.dart';

import '../../test_utils/image_mock_http_client.dart';
import '../../test_utils/widget_test_utility.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    registerFallbackValue(Uri());

    // Load an image from assets and transform it from bytes to List<int>
    final imageByteData = await rootBundle.load('assets/surfaces/dirt.png');
    final imageIntList = imageByteData.buffer.asInt8List();

    final requestsMap = {
      Uri.parse(AppImagePaths.placeholderMap): imageIntList,
    };

    HttpOverrides.global = MockHttpOverrides(requestsMap);
  });

  group(
    'Recommended routes list',
    () {
      testWidgets(
        'Is present, show list data.',
        (WidgetTester tester) async {
          /// Arrange
          List<RecommendedRoute> routes = [
            RecommendedRoute(
                imagePath: AppImagePaths.placeholderMap,
                title: 'A',
                location: 'Bamberg',
                rating: '4')
          ];
          var sut = wrapWidgetForTesting(RecommendedRoutes(
            routes: routes,
          ));
          await tester.pumpWidget(sut);
          await tester.pumpAndSettle();

          /// Act
          final itemFinder = find.byType(SquareRouteCard);
          final iconFinder = find.byIcon(Icons.star);
          final titleFinder = find.byType(RouteCardTitle);
          final ratingFinder = find.byType(RouteCardRating);

          /// Assert
          expect(itemFinder, findsOneWidget);
          expect(iconFinder, findsOneWidget);
          expect(titleFinder, findsOneWidget);
          expect(ratingFinder, findsOneWidget);
        },
      );
    },
  );
}
