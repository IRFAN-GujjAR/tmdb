import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/core/entities/error/custom_error_entity.dart';
import 'package:tmdb/core/error/custom_error_types.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/ads_manager/domain/entities/ads_manager_entity.dart';
import 'package:tmdb/features/ads_manager/domain/use_cases/ads_manager_use_case_reset.dart';
import 'package:tmdb/features/ads_manager/domain/use_cases/ads_manager_use_case_update.dart';
import 'package:tmdb/features/ads_manager/domain/use_cases/ads_manager_use_case_watch.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_event.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_state.dart';

final class AdsManagerBloc extends Bloc<AdsManagerEvent, AdsManagerState> {
  final AdsManagerUseCaseWatch _useCaseWatch;
  final AdsManagerUseCaseUpdate _useCaseUpdate;
  final AdsManagerUseCaseReset _useCaseReset;
  late StreamSubscription _subscription;

  AdsManagerBloc(this._useCaseWatch, this._useCaseUpdate, this._useCaseReset)
    : super(AdsManagerState(AdsManagerEntity(functionCallCount: 0))) {
    _subscription = _useCaseWatch.call.listen((value) {
      if (value != null) {
        _onWatch(value);
      }
    });

    on<AdsManagerEvent>((event, emit) async {
      switch (event) {
        case AdsManagerEventUpdated():
          emit(AdsManagerState(event.adsManager));
          break;
        case AdsManagerEventIncrement():
          await _onIncrement(event, emit);
          break;
        case AdsManagerEventReset():
          await _onReset(emit);
          break;
      }
    });
  }

  void _onWatch(AdsManagerTableData value) {
    add(
      AdsManagerEventUpdated(
        AdsManagerEntity(functionCallCount: value.functionCallCount),
      ),
    );
  }

  Future<void> _onIncrement(
    AdsManagerEventIncrement event,
    Emitter<AdsManagerState> emit,
  ) async {
    try {
      await _useCaseUpdate.call(state.adsManager.functionCallCount + 1);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> _onReset(Emitter<AdsManagerState> emit) async {
    try {
      await _useCaseReset.call;
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  static void increment(AdsManagerBloc bloc) {
    bloc.add(const AdsManagerEventIncrement());
  }

  static void incrementOnError(AdsManagerBloc bloc, CustomErrorEntity error) {
    if (!error.type.isNetworkError) {
      bloc.add(const AdsManagerEventIncrement());
    }
  }
}
