import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wheelmap/common/constants/app_image_paths.dart';
import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/presentation/common_widgets/text_widgets.dart';
import 'package:wheelmap/presentation/discover/location_card.dart';

import '../../test_utils/image_mock_http_client.dart';
import '../../test_utils/widget_test_utility.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    registerFallbackValue(Uri());

    // Load an image from assets and transform it from bytes to List<int>
    final _imageByteData = await rootBundle.load('assets/surfaces/dirt.png');
    final _imageIntList = _imageByteData.buffer.asInt8List();

    final _requestsMap = {
      Uri.parse(AppImagePaths.placeholderMap): _imageIntList,
    };

    HttpOverrides.global = MockHttpOverrides(_requestsMap);
  });
  group(
    'Location card item',
    () {
      testWidgets(
        'Location card is present ',
        (WidgetTester tester) async {
          /// Arrange
          var sut = wrapWidgetForTesting(LocationCard());
          await tester.pumpWidget(sut);
          await tester.pumpAndSettle();

          /// Act
          final imageFinder = find.byType(Image);
          final subtitleFinder = find.byType(SubtitleText);
          final textFinder = find.text(AppStrings.exampleYourLocationText);

          /// Assert
          expect(imageFinder, findsOneWidget);
          expect(subtitleFinder, findsOneWidget);
          expect(textFinder, findsOneWidget);
        },
      );
    },
  );
}
