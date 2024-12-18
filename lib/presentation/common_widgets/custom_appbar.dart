import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wheelmap/common/constants/app_colors.dart';
import 'package:wheelmap/presentation/discover/appbar_icon_button.dart';

// Custom AppBar for all views (with respective titles)
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.amberPanelColor,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ],
      ),
    );
  }
}
