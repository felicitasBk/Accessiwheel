import 'package:flutter/material.dart';
import 'package:wheelmap/common/constants/app_colors.dart';
import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/presentation/discover/nearby_routes.dart';
import 'package:wheelmap/presentation/common_widgets/text_widgets.dart';

class FavouritesView extends StatefulWidget {
  const FavouritesView({super.key});

  @override
  State<FavouritesView> createState() => _FavouritesViewState();
}

class _FavouritesViewState extends State<FavouritesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(14),
            child: Column(
              children: [
                const SizedBox(height: 10),
                //Hero section (Recent trip)
                FavouritesHeroSection(),
                //Favourite Routes section
                Expanded(
                  child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: const [
                        SizedBox(height: 20),
                        NearbyRoutes(),
                      ]),
                ),
              ],
            )));
  }
}

class DetailsElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DetailsElevatedButton(
    {Key? key, 
    required this.onPressed}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 8.0,
        )),
        child: Text(
          AppStrings.routeButtonText,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        )
    );
  }
}

class FavouritesHeroSection extends StatelessWidget {
  const FavouritesHeroSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 220,
      decoration: FavouritesHeroSectionBoxDecoration(),
      child: FavouritesHeroSectionContent(),
    );
  }
}

class FavouritesHeroSectionBoxDecoration extends BoxDecoration {
  FavouritesHeroSectionBoxDecoration()
    : super(
        gradient: LinearGradient(colors: [
          AppColors.amberGradientFirstColor,
          AppColors.amberGradientSecondColor.withOpacity(0.6)
        ], begin: Alignment.bottomLeft, end: Alignment.topRight),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(80),
        ),
        boxShadow: const [
          BoxShadow(
              offset: Offset(7, 7),
              blurRadius: 12,
              color: Colors.black12
            ),
        ],
      );
}

class FavouritesHeroSectionContent extends StatelessWidget {
  const FavouritesHeroSectionContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.only(left: 20, top: 25, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.recentTripText,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 5),
            Text(
              AppStrings.exampleRecentTripTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 50),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(Icons.timer,
                        size: 20,
                        color: AppColors.amberSubtitleTextColor),
                    const SizedBox(width: 10),
                    Text(
                      AppStrings.exampleTripDurationText,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Expanded(child: Container()),
                PlayButton()
              ],
            )
          ],
        ),
      );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          boxShadow: [
            BoxShadow(
                color: AppColors.amberGradientFirstColor
                    .withOpacity(0.8),
                blurRadius: 10,
                offset: const Offset(3, 6))
          ]),
      child: const Icon(Icons.play_circle_fill,
          color: Colors.white, size: 60),
    );
  }
}
