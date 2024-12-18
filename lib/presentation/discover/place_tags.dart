import 'package:flutter/material.dart';
import 'package:wheelmap/common/constants/app_colors.dart';
import 'package:wheelmap/common/constants/app_strings.dart';

// Class to create place tags to filter search results
class PlaceTags extends StatelessWidget {
  final List<String> tags;
  const PlaceTags({super.key, this.tags = const []});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return PlaceTag(placeTagText: AppStrings.examplePlaceTagText);
        },
        separatorBuilder: (context, index) =>
            const Padding(padding: EdgeInsets.only(right: 10)),
        //TODO: - Change this item count to dynamic
        itemCount: tags.isNotEmpty ? tags.length : 5, //number of tags created
      ),
    );
  }
}

class PlaceTag extends StatelessWidget {
  final String placeTagText;

  const PlaceTag({
    Key? key,
    required this.placeTagText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(placeTagText),
      avatar: CircleAvatar(
        backgroundColor: AppColors.amberGradientFirstColor,
        child: Icon(Icons.place,
            size: 20, color: AppColors.amberSubtitleTextColor),
      ),
      backgroundColor: AppColors.amberBackgroundColor,
      elevation: 0.4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
