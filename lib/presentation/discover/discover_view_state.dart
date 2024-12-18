import 'package:equatable/equatable.dart';
import 'package:wheelmap/common/enum/loading_status.dart';
import 'package:wheelmap/data/API/error_message.dart';
import 'package:wheelmap/domain/entities/routes.dart';

// State for Discover View
class DiscoverViewState with EquatableMixin {

  List<Route> routesData;
  LoadingStatus loadingStatus;
  ErrorMessage? errorMessage;

  DiscoverViewState({
    required this.routesData,
    required this.loadingStatus,
    required this.errorMessage
  });

  factory DiscoverViewState.init() {
    return DiscoverViewState(
        routesData: [],
        loadingStatus: LoadingStatus.loading,
        errorMessage: null,
    );
  }

  DiscoverViewState copyWith(
      {
        List<Route>? routesData,
        LoadingStatus? loadingStatus,
        ErrorMessage? errorMessage
      })
    {
    return DiscoverViewState(
        routesData: routesData ?? this.routesData,
        loadingStatus: loadingStatus ?? this.loadingStatus,
        errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [
    routesData,
    loadingStatus,
    errorMessage
  ];
}
