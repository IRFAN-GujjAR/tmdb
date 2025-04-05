import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:tmdb/features/main/tmdb/domain/entities/account_details_entity.dart';

sealed class TMDbEvent extends Equatable {
  const TMDbEvent();
}

final class TMDbEventLoadAccountDetails extends TMDbEvent {
  final String sessionId;

  const TMDbEventLoadAccountDetails(this.sessionId);

  @override
  List<Object?> get props => [sessionId];
}

final class TMDbEventNotifyAccountDetails extends TMDbEvent {
  final AccountDetailsEntity? accountDetails;

  const TMDbEventNotifyAccountDetails(this.accountDetails);

  @override
  List<Object?> get props => [accountDetails];
}

final class TMDbEventRefreshAccountDetails extends TMDbEvent {
  final String sessionId;
  final Completer<void> completer;
  const TMDbEventRefreshAccountDetails(this.sessionId, this.completer);

  @override
  List<Object?> get props => [sessionId, completer];
}

final class TMDbEventSignOut extends TMDbEvent {
  const TMDbEventSignOut();

  @override
  List<Object?> get props => [];
}
