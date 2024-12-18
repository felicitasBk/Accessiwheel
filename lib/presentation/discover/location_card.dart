import 'package:flutter/material.dart';
import 'package:wheelmap/common/constants/app_image_paths.dart';
import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/presentation/common_widgets/custom_network_image.dart';
import 'package:wheelmap/presentation/common_widgets/text_widgets.dart';

// Class to create card showing current user location
class LocationCard extends StatelessWidget {
  const LocationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CustomNetworkImage(
                imageUrl: AppImagePaths.placeholderMap,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SubtitleText(text: AppStrings.yourLocationTitle),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppStrings.exampleYourLocationText,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
