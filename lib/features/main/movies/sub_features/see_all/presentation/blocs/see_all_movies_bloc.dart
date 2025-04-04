import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb/core/entities/error/custom_error_entity.dart';
import 'package:tmdb/core/entities/movie/movies_list_entity.dart';
import 'package:tmdb/core/error/custom_error_utl.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/main/movies/sub_features/see_all/domain/use_cases/params/see_all_movies_params.dart';
import 'package:tmdb/features/main/movies/sub_features/see_all/domain/use_cases/see_all_movies_use_case.dart';

part 'see_all_movies_event.dart';
part 'see_all_movies_state.dart';

class SeeAllMoviesBloc extends Bloc<SeeAllMoviesEvent, SeeAllMoviesState> {
  final AdsManagerBloc _adsManagerBloc;
  final SeeAllMoviesUseCase _useCase;

  SeeAllMoviesBloc(this._adsManagerBloc, this._useCase)
    : super(SeeAllMoviesStateInitial()) {
    on<SeeAllMoviesEvent>((event, emit) async {
      switch (event) {
        case SeeAllMoviesEventLoad():
          await _onLoad(event, emit);
          break;
      }
    });
  }

  Future<void> _onLoad(
    SeeAllMoviesEventLoad event,
    Emitter<SeeAllMoviesState> emit,
  ) async {
    emit(SeeAllMoviesStateLoading());
    try {
      final moviesList = await _useCase.call(event.params);
      AdsManagerBloc.increment(_adsManagerBloc);
      emit(SeeAllMoviesStateLoaded(moviesList));
    } catch (e) {
      logger.e(e);
      final error = CustomErrorUtl.getError(e);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, error);
      emit(SeeAllMoviesStateError(error: error));
    }
  }
}
