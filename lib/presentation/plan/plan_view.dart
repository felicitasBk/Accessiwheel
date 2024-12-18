import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wheelmap/common/constants/app_colors.dart';
import 'package:wheelmap/common/constants/app_constants.dart';
import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/common/enum/loading_status.dart';
import 'package:wheelmap/data/repositories/plan_repository.dart';
import 'package:wheelmap/domain/entities/properties_extension.dart';
import 'package:wheelmap/presentation/common_widgets/text_widgets.dart';
import 'package:wheelmap/presentation/discover/appbar_icon_button.dart';
import 'package:wheelmap/presentation/discover/instructions.dart';
import 'package:wheelmap/presentation/plan/plan_cubit.dart';
import 'package:wheelmap/presentation/plan/plan_state.dart';
import 'package:wheelmap/presentation/plan/widgets/marker/marker_list_view.dart';
import 'package:fl_chart/fl_chart.dart';

import '../discover/accessibility_highlights.dart';

class PlansView extends StatelessWidget {
  bool isDefault;
  final List<List<double>> coordinates;
  PlansView({super.key, this.isDefault = true, required this.coordinates});

  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlanCubit(
        PlanRepository(),
          coordinates,
          context
      )..init(),
      child: BlocBuilder<PlanCubit, PlanState>(
        builder: (context, state) {
          PlanCubit cubit = context.read<PlanCubit>();
          final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();
          if(state.isShowingAltRoutes){
            Future.delayed(Duration(seconds: 1), () {
              tooltipkey.currentState?.ensureTooltipVisible();
            });
            
          }
          if (state.loadingStatus == LoadingStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.errorMessage != null) {
            return Center(
              child: Text('$state.errorMessage'),
            );
          }

          if (state.polyLines.isNotEmpty) {
            return Scaffold(
              appBar: isDefault
                  ? null
                  : AppBar(
                      backgroundColor: AppColors.amberPanelColor,
                      iconTheme: IconThemeData(color: Colors.black),
                      title: Text(
                        'Plans',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      leading: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () => (context.canPop())
                              ? Navigator.pop(context)
                              : context.goNamed('home')),
                      actions: <Widget>[
                        (state.isShowingAltRoutes)
                            ? Tooltip(
                              // Provide a global key with the "TooltipState" type to show
                              // the tooltip manually when trigger mode is set to manual.
                              key: tooltipkey,
                              triggerMode: TooltipTriggerMode.manual,
                              showDuration: const Duration(seconds: 3),
                              message: 'Tap this button to reset to original route',
                              child: AppBarIconButton(
                                onPressed: () {
                                  cubit
                                      .fetchMarkers(coordinates)
                                      .then((value) => cubit.fetchPolyLines(coordinates));

                                  cubit.emit(state.copyWith(
                                      isShowingAltRoutes: false));
                                },
                                icon: Icon(
                                  Icons.restart_alt,
                                ),
                              ),
                            )
                            : Container()
                      ],
                    ),
              body: SlidingUpPanel(
                backdropEnabled: true,
                color: Colors.transparent,
                minHeight: 80,
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                      blurRadius: 10.0, color: Color.fromRGBO(0, 0, 0, 0.2))
                ],
                panelBuilder: (ScrollController sc) =>
                    _customSlidingUpPanel(sc, state, context),
                // panel: CustomSlidingUpPanel(state) ,
                body: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                      onPositionChanged: (position, _) {
                        state.rotation = _mapController.rotation;
                      },
                      center: latlong2.LatLng(
                        state.featureMarkers[0].geometry.coordinate.latitude,
                        state.featureMarkers[0].geometry.coordinate.longitude,
                      ),
                      zoom: 14.0,
                      maxZoom: 18.25),
                  children: [
                    TileLayer(
                      urlTemplate: tileLayerURL,
                    ),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          //TODO: Update map to loop thru model
                          points: state.polyLines
                              .map((polyline) => latlong2.LatLng(
                                    polyline.getLat(),
                                    polyline.getLng(),
                                  ))
                              .toList(),
                          color: Colors.blue,
                          strokeWidth: 2.5,
                        ),
                      ],
                    ),
                    MarkerListView(),
                  ],
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}

Widget _customSlidingUpPanel(
    ScrollController scrollController, PlanState state, BuildContext context) {
  int wheelchairAccessible = 0;
  int partiallyWheelchairAccessible = 0;
  int guideDogAccessible = 0;
  List<String> wheelchairAccessiblePlaces = [];
  List<String> partiallyWheelchairAccessiblePlaces = [];
  List<String> guideDogAccessiblePlaces = [];
  int totalPoints = 0;
  final PlanCubit cubit = context.read<PlanCubit>();
  var index = 1;
  final List<FlSpot> stateSteepnessData =
      state.steepness.map<FlSpot>((steepness) {
    var spot = FlSpot(index.toDouble(), steepness.getValue.toDouble());
    index++;
    return spot;
  }).toList();

  final List<FlSpot> steepnessData = [
    ...[FlSpot(0.0, 0.0)],
    ...stateSteepnessData
  ];

  return Container(
      decoration: BoxDecoration(
        color: AppColors.amberPanelColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Column(
        children: <Widget>[
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
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
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
              padding: EdgeInsets.all(8.0),
              child: Scrollbar(
                child: ListView(
                  controller: scrollController,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SubtitleText(text: AppStrings.accessibilitySummaryText)
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                        child: Wrap(
                          children: state.featureMarkers.map((marker) {
                            if (marker.properties.accessibility.accessibleWith?.wheelchair ==
                                true) {
                              wheelchairAccessible++;
                              wheelchairAccessiblePlaces.add(marker.properties.getName());
                            }
                            if (marker.properties.accessibility.partiallyAccessibleWith?.wheelchair ==
                                true) {
                              partiallyWheelchairAccessible++;
                              partiallyWheelchairAccessiblePlaces.add(marker.properties.getName());
                            }
                            if (marker.properties.accessibility.accessibleWith?.guideDog ==
                                true) {
                              guideDogAccessible++;
                              guideDogAccessiblePlaces.add(marker.properties.getName());
                            }
                            totalPoints++;
                            return Row(children: [
                              Flexible(
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.red,
                                        ), // Replace with the desired icon widget
                                        SizedBox(
                                            width:
                                            8), // Add some spacing between the icon and text
                                        Text(marker.properties.getName()),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    //Icon(Icons.circle, size: 10, color: Colors.black,),
                                  ]))
                            ]);
                          }).toList(),
                        )
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    AccessibilityHighlights(
                      wheelchairAccessiblePlaces: wheelchairAccessiblePlaces,
                      partiallyWheelchairAccessiblePlaces: partiallyWheelchairAccessiblePlaces,
                      guideDogAccessiblePlaces: guideDogAccessiblePlaces,
                      wheelchairAccessible: wheelchairAccessible,
                      partiallyWheelchairAccessible: partiallyWheelchairAccessible,
                      guideDogAccessible: guideDogAccessible,
                      totalPoints:totalPoints,
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          AppStrings.accessibilityFurtherDetailsText,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    Row(
                      children: [
                        SubtitleText(text: AppStrings.accessibilitySurfaceText)
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 3,
                          ),
                          itemCount: state.surfaces.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            final surface = state.surfaces[index];
                            return Column(
                              children: <Widget>[
                                Expanded(
                                  child: Image.asset(
                                    surface.getImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  "${surface.getName} (${surface.getPercentage}%)",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            );
                          },
                        )),
                    SizedBox(height: 10),
                    Divider(),
                    Row(
                      children: [
                        SubtitleText(text: AppStrings.accessibilitySteepnessText)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                      child: Row(
                        children: state.steepness.map<Widget>((steepness) {
                          var icon = Icons.arrow_right_alt;
                          if (steepness.getValue > 0) {
                            icon = Icons.north_east;
                          } else if (steepness.getValue < 0) {
                            icon = Icons.south_east;
                          }
                          return Row(
                            children: <Widget>[
                              Icon(icon),
                              Text(": ${steepness.getPercentage}")
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      child: LineChart(LineChartData(
                          baselineY: 0.0,
                          minY: -5.0,
                          maxY: 5.0,
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                          ),
                          lineBarsData: [
                            // The red line
                            LineChartBarData(
                                spots: steepnessData,
                                isCurved: true,
                                barWidth: 3,
                                color: AppColors.amberGradientFirstColor,
                                dotData: FlDotData(show: false)),
                          ])),
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    InstructionsPanel(
                      instructionExpanded: state.instructionExpanded,
                      updateInstructionExpanded: (bool expanded) {
                        cubit.updateInstructionExpanded(expanded);
                      },
                      instructions: state.instructions,
                      cubit: cubit, // Add this line
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ));
}

class SlidingUpBarIndicator extends StatelessWidget {
  const SlidingUpBarIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: 45,
          height: 5,
          decoration: const BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ));
  }
}
