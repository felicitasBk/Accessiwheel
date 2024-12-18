import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheelmap/data/repositories/discover_repository.dart';
import 'package:wheelmap/presentation/discover/discover_view_state.dart';
import 'package:wheelmap/common/enum/loading_status.dart';
import 'package:wheelmap/data/API/error_message.dart';

class DiscoverCubit extends Cubit<DiscoverViewState> {
  final DiscoverRepository discoverRepository;
  DiscoverCubit(this.discoverRepository) : super(DiscoverViewState.init());

  void init() async {
    await fetchRoutesData();
  }

  Future<void> fetchRoutesData() async {
    try {
      final routesData = await discoverRepository.getRoutesData();
      emit(state.copyWith(
          routesData: routesData, loadingStatus: LoadingStatus.loaded));
    }
    catch (e) {
      ErrorMessage errorMessage = ErrorMessage(e.toString(), "Error Fetching JSON", 100);
      emit(state.copyWith(errorMessage: errorMessage));
    }
  }
}