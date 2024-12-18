import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wheelmap/common/constants/app_colors.dart';
import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/domain/entities/routes.dart';
import 'package:wheelmap/presentation/common_widgets/custom_network_image.dart';
import 'package:wheelmap/presentation/common_widgets/text_widgets.dart';
import 'package:wheelmap/presentation/plan/plan_view.dart';

class RectangularRouteCard extends StatelessWidget {
  final String routeImagePath;
  final String routeTitle;
  final String routeLocation;
  final String routeDescription;
  final String routeRating;
  final List<Waypoint> routeWaypoints;

  const RectangularRouteCard(
      {Key? key,
      required this.routeImagePath,
      required this.routeTitle,
      required this.routeLocation,
      required this.routeDescription,
      required this.routeRating,
      required this.routeWaypoints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 3;
    double height = width * .66;
    return Card(
      elevation: 0.4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          //TODO:- Pass the necessary data to Plan view from here.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                List<List<double>> coordinates = [];
                for (Waypoint waypoint in routeWaypoints.cast<Waypoint>()) {
                  coordinates.add([waypoint.longitude, waypoint.latitude]);
                }
                return PlansView(isDefault: false, coordinates: coordinates);
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 150.0,
                    width: 150.0,
                    child: CustomNetworkImage(
                      imageUrl: routeImagePath,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              RectangularRouteCardTextInfo(
                  routeTitle: routeTitle,
                  routeLocation: routeLocation,
                  routeDescription: routeDescription,
                  routeRating: routeRating)
            ],
          ),
        ),
      ),
    );
  }
}

class RectangularRouteCardTextInfo extends StatelessWidget {
  final String routeTitle;
  final String routeLocation;
  final String routeDescription;
  final String routeRating;

  const RectangularRouteCardTextInfo({
    Key? key,
    required this.routeTitle,
    required this.routeLocation,
    required this.routeDescription,
    required this.routeRating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        RouteCardTitle(text: routeTitle),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Icon(
                Ionicons.location,
                color: Theme.of(context).primaryColor,
                size: 16,
              ),
            ),
            const SizedBox(width: 2),
            RouteCardLocation(text: routeLocation)
          ],
        ),
        const Spacer(),
        Row(
          children: [
            Icon(
              Icons.star,
              color: Colors.yellow.shade700,
              size: 14,
            ),
            RouteCardRating(text: routeRating)
          ],
        ),
        Row(
          children: [
            Expanded(child: RouteCardDescription(text: routeDescription)),
            TextButtonLabel(
                text: AppStrings.routeButtonText,
                style: Theme.of(context).textTheme.labelMedium),
            Icon(Icons.arrow_forward_ios,
                size: 10, color: AppColors.amberSubtitleTextColor)
          ],
        )
      ]),
    );
  }
}
