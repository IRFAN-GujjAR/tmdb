import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/error/custom_error_utl.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/domain/use_cases/celebrity_details_use_case.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/presentation/blocs/celebrity_details_event.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/presentation/blocs/celebrity_details_state.dart';

final class CelebrityDetailsBloc
    extends Bloc<CelebrityDetailsEvent, CelebrityDetailsState> {
  final AdsManagerBloc _adsManagerBloc;
  final CelebrityDetailsUseCase _useCase;

  CelebrityDetailsBloc(this._adsManagerBloc, this._useCase)
    : super(CelebrityDetailsStateInitial()) {
    on<CelebrityDetailsEventLoad>((event, emit) async {
      await _onLoad(event, emit);
    });
  }

  Future<void> _onLoad(
    CelebrityDetailsEventLoad event,
    Emitter<CelebrityDetailsState> emit,
  ) async {
    emit(CelebrityDetailsStateLoading());
    try {
      final celebritiesDetails = await _useCase.call(event.celebId);
      AdsManagerBloc.increment(_adsManagerBloc);
      emit(CelebrityDetailsStateLoaded(celebritiesDetails));
    } catch (e) {
      logger.e(e);
      final error = CustomErrorUtl.getError(e);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, error);
      emit(CelebrityDetailsStateError(error));
    }
  }
}
