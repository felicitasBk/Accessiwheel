import 'package:flutter/material.dart';
import 'package:wheelmap/common/constants/app_colors.dart';
import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/domain/entities/feature.dart';
import 'package:wheelmap/domain/entities/nearest_location.dart';
import 'package:wheelmap/presentation/plan/widgets/alternative_location/nearest_location_overview.dart';
import 'package:wheelmap/presentation/plan/widgets/marker/accessibility_expansion_view.dart';
import 'package:wheelmap/presentation/plan/widgets/marker/general_info_view.dart';

class AlternativesView extends StatefulWidget {
  final Feature marker;
  final List<NearestLocation> nearestLocations;
  Function? callBack;
  AlternativesView({
    Key? key,
    required this.marker,
    required this.nearestLocations,
    required this.callBack,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AlternativesViewState();
  }
}

class _AlternativesViewState extends State<AlternativesView> {
  Map<String, bool> expandedLocations = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.amberPanelColor,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            'Alternatives',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Scrollbar(
            child: SingleChildScrollView(
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(),
                _buildNearestLocationsMenu(context),
              ]),
            ),
          ),
        ));
  }

  Widget _buildNearestLocationsMenu(BuildContext context) {
    Feature marker = widget.marker;
    List<NearestLocation> locations = widget.nearestLocations;
    return marker.properties.category == 'undefined'
        ? Text(
            AppStrings.noAlternativesFoundText,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          )
        : Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      'Nearest alternatives (Category: ${marker.properties.category.toUpperCase()}):',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              if (locations.isNotEmpty)
                Column(
                  children: locations.map((location) {
                    final isLocationExpanded =
                        expandedLocations[location.properties.id] ?? false;
                    return ExpansionPanelList(
                        elevation: 1,
                        expandedHeaderPadding: EdgeInsets.all(0),
                        expansionCallback: (panelIndex, isExpanded) {
                          _toggleItem(location.properties.id);
                        },
                        children: [
                          ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: NearestLocationOverview(
                                  location: location,
                                  onTapLocation: (locationId) {
                                    _toggleItem(locationId);
                                  },
                                ),
                              );
                            },
                            body: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GeneralInfoView(
                                      location: location,
                                      leftPadding: 14.0,
                                      isAddressShown: false),
                                  SizedBox(height: 8.0),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                                    child: AccessibilityExpansionView(
                                      location: location,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (widget.callBack != null) {
                                          widget.callBack!(
                                              widget.marker, location);
                                        }
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                            horizontal: 8.0,
                                          )),
                                      child: Text(
                                        AppStrings.selectAlternativeButtonText,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            isExpanded: _isExpanded(location.properties.id),
                          )
                        ]);
                  }).toList(),
                ),
              if (widget.nearestLocations.isEmpty)
                Text(
                  'No alternatives found for this location',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
            ],
          );
  }

  void _toggleItem(String id) {
    bool isExpanded = expandedLocations[id] ?? false;
    setState(() {
      expandedLocations[id] = !isExpanded;
    });
  }

  bool _isExpanded(String id) {
    return expandedLocations[id] ?? false;
  }
}
