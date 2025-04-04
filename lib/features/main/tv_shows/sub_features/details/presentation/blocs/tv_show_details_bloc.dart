import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb/core/entities/error/custom_error_entity.dart';
import 'package:tmdb/core/error/custom_error_utl.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/domain/entities/tv_show_details_entity.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/domain/use_cases/tv_show_details_use_case.dart';

part 'tv_show_details_event.dart';
part 'tv_show_details_state.dart';

class TvShowDetailsBloc extends Bloc<TvShowDetailsEvent, TvShowDetailsState> {
  final AdsManagerBloc _adsManagerBloc;
  final TvShowDetailsUseCase _useCase;

  TvShowDetailsBloc(this._adsManagerBloc, this._useCase)
    : super(TvShowDetailsStateInitial()) {
    on<TvShowDetailsEventLoad>((event, emit) async {
      await _onLoad(event, emit);
    });
  }

  Future<void> _onLoad(
    TvShowDetailsEventLoad event,
    Emitter<TvShowDetailsState> emit,
  ) async {
    emit(TvShowDetailsStateLoading());
    try {
      final tvShowDetails = await _useCase.call(event.tvId);
      AdsManagerBloc.increment(_adsManagerBloc);
      emit(TvShowDetailsStateLoaded(tvShowDetails: tvShowDetails));
    } catch (e) {
      logger.e(e);
      final error = CustomErrorUtl.getError(e);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, error);
      emit(TvShowDetailsStateError(error: error));
    }
  }
}
