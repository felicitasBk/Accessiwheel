import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/common/enum/loading_status.dart';
import 'package:wheelmap/data/repositories/discover_repository.dart';
import 'package:wheelmap/presentation/common_widgets/rectangular_route_card.dart';
import 'package:wheelmap/presentation/discover/discover_cubit.dart';
import 'package:wheelmap/presentation/discover/discover_view_state.dart';

// Class to create rectangular route cards
// (generally used for personalized routes such as Favourites/Near From You routes)
class NearbyRoutes extends StatelessWidget {
  const NearbyRoutes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DiscoverCubit(
        DiscoverRepository(),
      )..init(),
      child: BlocBuilder<DiscoverCubit, DiscoverViewState>(
        builder: (context, state) {
          if (state.loadingStatus == LoadingStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.routesData.isNotEmpty) {
            // Data has been successfully loaded
            final data = state.routesData;
            return Column(
              children: List.generate(
                  data.length /*number of route cards created*/, (index) {
                // Access the data using index
                final item = data[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                      height: 135,
                      width: double.maxFinite,
                      child: RectangularRouteCard(
                          routeImagePath: item.imageURL,
                          routeTitle: item.name,
                          routeWaypoints: item.waypoints,
                          routeLocation: AppStrings.exampleRouteLocation,
                          routeDescription: item.description,
                          routeRating: item.rating)),
                );
              }),
            );
          }
          return Container();
        },
      ),
    ); // Bloc
  }
}
