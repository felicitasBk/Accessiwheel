import 'package:flutter/material.dart';
import 'package:wheelmap/common/constants/app_colors.dart';

// Class to create custom icon buttons such as Search and Notification buttons inside AppBar
class AppBarIconButton extends StatelessWidget {
  final Widget icon;
  final Function()? onPressed;

  const AppBarIconButton({Key? key, required this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(color: AppColors.amberLabelTextColor.withOpacity(0.4)),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed != null ? () => onPressed!() : () {},
        constraints: const BoxConstraints.tightFor(width: 40),
        color: AppColors.amberSubtitleTextColor,
        icon: icon,
        splashRadius: 22,
      ),
    );
  }
}
