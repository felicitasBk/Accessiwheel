import 'package:flutter/material.dart';
import 'package:wheelmap/domain/entities/feature.dart';
import 'package:wheelmap/presentation/plan/widgets/marker/marker_popup_dialog_helper.dart';

class ContactInfoView extends StatelessWidget {
  final Feature location;

  const ContactInfoView({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MarkerPopupDialogHelper helper = MarkerPopupDialogHelper(location);

    return Column(
      children: [
        if (helper.isPhoneNumberInfoAvailable())
          Row(
            children: [
              Icon(
                Icons.phone,
                size: 20,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  location.properties.phoneNumber!,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        if (helper.isPlaceWebsiteUrlInfoAvailable())
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.public,
                size: 20,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  location.properties.placeWebsiteUrl!,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
