import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb/core/entities/celebs/celebrities_list_entity.dart';
import 'package:tmdb/core/entities/error/custom_error_entity.dart';
import 'package:tmdb/core/error/custom_error_utl.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/main/celebrities/sub_features/see_all/domain/use_cases/see_all_celebs_use_case.dart';

part 'see_all_celebs_event.dart';
part 'see_all_celebs_state.dart';

class SeeAllCelebsBloc extends Bloc<SeeAllCelebsEvent, SeeAllCelebsState> {
  final AdsManagerBloc _adsManagerBloc;
  final SeeAllCelebsUseCase _useCase;

  SeeAllCelebsBloc(this._adsManagerBloc, this._useCase)
    : super(SeeAllCelebsStateInitial()) {
    on<SeeAllCelebsEvent>((event, emit) async {
      switch (event) {
        case SeeAllCelebsEventLoad():
          await _onLoad(event, emit);
          break;
      }
    });
  }

  Future<void> _onLoad(
    SeeAllCelebsEventLoad event,
    Emitter<SeeAllCelebsState> emit,
  ) async {
    emit(SeeAllCelebsStateLoading());
    try {
      final celebritiesList = await _useCase.call(event.params);
      AdsManagerBloc.increment(_adsManagerBloc);
      emit(SeeAllCelebsStateLoaded(celebritiesList));
    } catch (e) {
      logger.e(e);
      final error = CustomErrorUtl.getError(e);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, error);
      emit(SeeAllCelebsStateError(error));
    }
  }
}
