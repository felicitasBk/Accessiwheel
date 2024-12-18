import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheelmap/domain/entities/feature.dart';
import 'package:wheelmap/domain/entities/properties_extension.dart';
import 'package:wheelmap/presentation/plan/plan_cubit.dart';
import 'package:wheelmap/presentation/plan/widgets/alternative_location/alternatives_view.dart';
import 'package:wheelmap/presentation/plan/widgets/marker/accessibility_expansion_view.dart';
import 'package:wheelmap/presentation/plan/widgets/marker/contact_info_view.dart';
import 'package:wheelmap/presentation/plan/widgets/marker/general_info_view.dart';
import 'package:wheelmap/presentation/plan/widgets/marker/marker_cubit.dart';
import 'package:wheelmap/presentation/plan/widgets/marker/marker_popup_dialog_header.dart';
import 'package:wheelmap/presentation/plan/widgets/marker/marker_state.dart';

class MarkerPopupDialog extends StatelessWidget {
  final Feature marker;

  Function? callBack;

  MarkerPopupDialog({Key? key, required this.marker, required this.callBack})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final minimumHeight = screenHeight * 0.25;
    final maximumHeight = screenHeight * 0.5;
    PlanCubit planCubit = context.read<PlanCubit>();
    planCubit.fetchNearestLocations(marker);
    return BlocProvider(
      create: (_) => MarkerCubit(marker),
      child: BlocBuilder<MarkerCubit, MarkerState>(
        builder: (_, state) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Container(
              constraints: BoxConstraints(
                minHeight: minimumHeight,
                maxHeight: maximumHeight,
              ),
              padding: EdgeInsets.all(16.0),
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MarkerPopupDialogHeader(
                        locationName: marker.properties.getName(),
                      ),
                      SizedBox(height: 8.0),
                      GeneralInfoView(
                          location: marker,
                          leftPadding: 0.0,
                          isAddressShown: true),
                      SizedBox(height: 8.0),
                      AccessibilityExpansionView(
                        location: marker,
                      ),
                      SizedBox(height: 16.0),
                      ContactInfoView(
                        location: marker,
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) {
                                return AlternativesView(
                                  marker: marker,
                                  nearestLocations:
                                      planCubit.state.nearestLocations,
                                  callBack: callBack,
                                );
                              }),
                            );
                          },
                          child: Text('View alternatives'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
