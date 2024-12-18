import 'package:flutter/material.dart';
import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/presentation/common_widgets/text_widgets.dart';

class AccessibilityHighlights extends StatelessWidget {
  const AccessibilityHighlights({
    Key? key,
    required this.wheelchairAccessiblePlaces,
    required this.partiallyWheelchairAccessiblePlaces,
    required this.guideDogAccessiblePlaces,
    required this.totalPoints,
    required this.wheelchairAccessible,
    required this.partiallyWheelchairAccessible,
    required this.guideDogAccessible,

  }) : super(key: key);

  final List<String> wheelchairAccessiblePlaces;
  final List<String> partiallyWheelchairAccessiblePlaces;
  final List<String> guideDogAccessiblePlaces;
  final int totalPoints;
  final int wheelchairAccessible;
  final int partiallyWheelchairAccessible;
  final int guideDogAccessible;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SubtitleText(text: AppStrings.accessibilityInformationText),
          ],
        ),
        Row(
          children: [
            Flexible(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Out of $totalPoints places in this route:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.accessible,
            ),
            Flexible(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SlidingUpPanelHighlights(text: 'Wheelchair Accessible:'),
                      Text(' $wheelchairAccessible place(s)'),
                    ]
                  )
                ],
              ),
            ),
          ],
        ),
        if (wheelchairAccessiblePlaces.isNotEmpty)
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Icon(
                      Icons.location_on,
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (String place in wheelchairAccessiblePlaces)
                          Text(place),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        SizedBox(height: 15.0),
        Row(
          children: [
            Icon(
              Icons.accessible,
            ),
            Flexible(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                      children: [
                        SlidingUpPanelHighlights(text: 'Partially Wheelchair Accessible:'),
                        Text(' $partiallyWheelchairAccessible place(s)'),
                      ]
                  )
                ],
              ),
            ),
          ],
        ),
        if (partiallyWheelchairAccessiblePlaces.isNotEmpty)
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Icon(
                      Icons.location_on,
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (String place in partiallyWheelchairAccessiblePlaces)
                          Text(place),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        SizedBox(height: 15.0),
        Row(
          children: [
            Icon(
              Icons.pets_outlined,
            ),
            Flexible(
              child: Column(
                children: [
                  Row(
                    children: [
                      SlidingUpPanelHighlights(text: 'Guide Dog Friendly:'),
                      Text(' $guideDogAccessible place(s)'),
                    ]
                  )
                ],
              ),
            ),
          ],
        ),
        if (guideDogAccessiblePlaces.isNotEmpty)
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Icon(
                      Icons.location_on,
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (String place in guideDogAccessiblePlaces)
                          Text(place),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
