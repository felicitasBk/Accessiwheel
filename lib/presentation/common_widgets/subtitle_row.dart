import 'package:flutter/material.dart';
import 'package:wheelmap/common/constants/app_colors.dart';
import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/presentation/common_widgets/text_widgets.dart';

class SubtitleRow extends StatelessWidget {
  final String text;

  const SubtitleRow({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SubtitleText(
          text: text,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerRight,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: TextButtonLabel(
                  text: AppStrings.moreTextButtonLabel,
                  style: Theme.of(context).textTheme.labelLarge)),
          Icon(Icons.arrow_forward_ios,
              size: 15, color: AppColors.amberSubtitleTextColor)
        ])
      ],
    );
  }
}
