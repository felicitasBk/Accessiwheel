import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:wheelmap/presentation/plan/plan_cubit.dart';
import 'package:wheelmap/presentation/plan/widgets/marker/marker_popup_dialog.dart';

class MarkerListView extends StatelessWidget {
  const MarkerListView({super.key});

  @override
  Widget build(BuildContext context) {
    PlanCubit cubit = context.read<PlanCubit>();
    return MarkerLayer(
      markers: cubit.state.featureMarkers.map(
        (marker) {
          return Marker(
            point: latlong2.LatLng(
              marker.geometry.coordinate.latitude,
              marker.geometry.coordinate.longitude,
            ),
            builder: (_) => GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return BlocProvider.value(
                      value: BlocProvider.of<PlanCubit>(context),
                      child: MarkerPopupDialog(
                        marker: marker,
                        callBack: cubit.updateRoute,
                      ),
                    );
                  },
                );
              },
              child: Transform.rotate(
                angle: -cubit.state.rotation * math.pi / 180,
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    (cubit.state.featureMarkers.indexOf(marker) + 1).toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
