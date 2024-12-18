import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/common/enum/loading_status.dart';
import 'package:wheelmap/data/repositories/discover_repository.dart';
import 'package:wheelmap/presentation/common_widgets/square_route_card.dart';
import 'package:wheelmap/presentation/discover/discover_cubit.dart';
import 'package:wheelmap/presentation/discover/discover_view_state.dart';
import 'package:wheelmap/presentation/discover/recommended_route.dart';
import 'package:wheelmap/domain/entities/routes.dart';

// Class to create square route cards
// (generally used for routes recommended by general community of Accessiwheel users)
//TODO: - Update recommended route with proper data.
class RecommendedRoutes extends StatelessWidget {
  List<RecommendedRoute> routes;
  RecommendedRoutes({super.key, this.routes = const []});

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
             List<Waypoint> waypoints =[];
              return SizedBox(
              height: 200,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final item = data[index];
                  return SizedBox(
                    width: 230,
                    child: SquareRouteCard(
                        routeImagePath: item.imageURL,
                        routeTitle: item.name,
                        routeLocation: AppStrings.exampleRouteLocation,
                        routeDescription: item.description,
                        routeRating: item.rating,
                        routeWaypoints: item.waypoints),
                  );
                },
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.only(right: 10),
                ),
                itemCount: data.length, //number of route cards created,
              ),
            );
          }
          else {
            return Text('No data');
          }
          return Container();
        },
      ),
    );



  }
}
