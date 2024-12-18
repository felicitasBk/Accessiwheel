import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/data/repositories/discover_repository.dart';
import 'package:wheelmap/presentation/common_widgets/subtitle_row.dart';
import 'package:wheelmap/presentation/discover/discover_cubit.dart';
import 'package:wheelmap/presentation/discover/discover_view_state.dart';
import 'package:wheelmap/presentation/discover/location_card.dart';
import 'package:wheelmap/presentation/discover/nearby_routes.dart';
import 'package:wheelmap/presentation/discover/place_tags.dart';
import 'package:wheelmap/presentation/discover/recommended_routes.dart';

class DiscoverView extends StatelessWidget {
  const DiscoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return DiscoverCubit(
          DiscoverRepository(),
        );
      },
      child: BlocBuilder<DiscoverCubit, DiscoverViewState>(
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    LocationCard(),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(height: 10),
                    SubtitleRow(text: AppStrings.fromCommunitySectionTitle),
                    SizedBox(height: 10),
                    RecommendedRoutes(),
                    SizedBox(height: 10),
                    SubtitleRow(text: AppStrings.nearFromYouSectionTitle),
                    SizedBox(height: 10),
                    NearbyRoutes(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
