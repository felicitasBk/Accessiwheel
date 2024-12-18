import 'package:flutter/material.dart';
import 'package:wheelmap/common/constants/app_colors.dart';
import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/presentation/plan/widgets/sliding_upbar_indicator.dart';

class CustomSlidingUpPanel extends StatelessWidget {
  const CustomSlidingUpPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.amberPanelColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 80,
            child: Column(
              children: [
                const SlidingUpBarIndicator(),
                Center(
                  child: Text(
                    AppStrings.accessibilityDetailsSlidingPanelText,
                    style: TextStyle(
                      color: AppColors.amberSubtitleTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
