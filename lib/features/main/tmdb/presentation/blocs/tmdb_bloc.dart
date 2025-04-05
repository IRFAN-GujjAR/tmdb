import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/core/error/custom_error_utl.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/app_startup/sub_features/user_session/domain/use_cases/user_session_delete_use_case.dart';
import 'package:tmdb/features/main/tmdb/domain/entities/account_details_entity.dart';
import 'package:tmdb/features/main/tmdb/domain/use_cases/account_details_use_case_delete.dart';
import 'package:tmdb/features/main/tmdb/domain/use_cases/account_details_use_case_load.dart';
import 'package:tmdb/features/main/tmdb/domain/use_cases/account_details_use_case_watch.dart';
import 'package:tmdb/features/main/tmdb/presentation/blocs/tmdb_event.dart';
import 'package:tmdb/features/main/tmdb/presentation/blocs/tmdb_state.dart';

final class TMDbBloc extends Bloc<TMDbEvent, TMDbState> {
  final AdsManagerBloc _adsManagerBloc;
  final AccountDetailsUseCaseWatch _useCaseWatch;
  final AccountDetailsUseCaseLoad _useCaseLoad;
  final AccountDetailsUseCaseDelete _useCaseDelete;
  final UserSessionDeleteUseCase _userSessionDeleteUseCase;
  late final StreamSubscription _subscription;

  TMDbBloc(
    this._adsManagerBloc,
    this._useCaseWatch,
    this._useCaseLoad,
    this._useCaseDelete,
    this._userSessionDeleteUseCase,
  ) : super(TMDbStateLoadingAccountDetails()) {
    _subscription = _useCaseWatch.call.listen((value) {
      _onWatch(value);
    });
    on<TMDbEvent>((event, emit) async {
      switch (event) {
        case TMDbEventLoadAccountDetails():
          await _onLoad(emit, sessionId: event.sessionId);
          break;
        case TMDbEventNotifyAccountDetails():
          _onUpdate(event, emit);
          break;
        case TMDbEventRefreshAccountDetails():
          await _onLoad(
            emit,
            sessionId: event.sessionId,
            completer: event.completer,
          );
          break;
        case TMDbEventSignOut():
          await _onSignOut(emit);
          break;
      }
    });
  }

  void _onWatch(AccountDetailsTableData? value) {
    add(
      TMDbEventNotifyAccountDetails(
        value != null
            ? AccountDetailsEntity(
              username: value.username,
              profilePath: value.profilePath,
            )
            : null,
      ),
    );
  }

  void _onUpdate(TMDbEventNotifyAccountDetails event, Emitter<TMDbState> emit) {
    if (event.accountDetails == null) {
      emit(TMDbStateAccountDetailsEmpty());
    } else {
      emit(TMDbStateAccountDetailsLoaded(event.accountDetails!));
    }
  }

  Future<void> _onLoad(
    Emitter<TMDbState> emit, {
    required String sessionId,
    Completer<void>? completer,
  }) async {
    if (state is TMDbStateErrorWithoutAccountDetailsCache ||
        state is TMDbStateSigningOutError)
      emit(TMDbStateLoadingAccountDetails());
    try {
      await _useCaseLoad.call(sessionId);
      AdsManagerBloc.increment(_adsManagerBloc);
      completer?.complete();
    } catch (e) {
      logger.e(e);
      completer?.complete();
      final error = CustomErrorUtl.getError(e);
      AdsManagerBloc.incrementOnError(_adsManagerBloc, error);
      if (state is TMDbStateAccountDetailsLoaded) {
        final data = state as TMDbStateAccountDetailsLoaded;
        emit(TMDbStateErrorWithAccountDetailsCache(data.accountDetails, error));
      } else {
        emit(TMDbStateErrorWithoutAccountDetailsCache(error));
      }
    }
  }

  Future<void> _onSignOut(Emitter<TMDbState> emit) async {
    emit(const TMDbStateSigningOut());
    try {
      await _userSessionDeleteUseCase.call;
      await _useCaseDelete.call;
      emit(const TMDbStateSignedOut());
    } catch (e) {
      logger.e(e);
      emit(TMDbStateSigningOutError(CustomErrorUtl.getError(e)));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
