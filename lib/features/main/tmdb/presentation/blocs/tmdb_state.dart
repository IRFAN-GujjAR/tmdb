import 'package:equatable/equatable.dart';
import 'package:tmdb/core/entities/error/custom_error_entity.dart';
import 'package:tmdb/features/main/tmdb/domain/entities/account_details_entity.dart';

sealed class TMDbState extends Equatable {
  const TMDbState();
}

final class TMDbStateLoadingAccountDetails extends TMDbState {
  const TMDbStateLoadingAccountDetails();

  @override
  List<Object?> get props => [];
}

final class TMDbStateAccountDetailsLoaded extends TMDbState {
  final AccountDetailsEntity accountDetails;

  const TMDbStateAccountDetailsLoaded(this.accountDetails);

  @override
  List<Object?> get props => [accountDetails];
}

final class TMDbStateAccountDetailsEmpty extends TMDbState {
  const TMDbStateAccountDetailsEmpty();

  @override
  List<Object?> get props => [];
}

final class TMDbStateSigningOut extends TMDbState {
  const TMDbStateSigningOut();

  @override
  List<Object?> get props => [];
}

final class TMDbStateErrorWithAccountDetailsCache extends TMDbState {
  final AccountDetailsEntity accountDetails;
  final CustomErrorEntity error;

  const TMDbStateErrorWithAccountDetailsCache(this.accountDetails, this.error);

  @override
  List<Object?> get props => [accountDetails, error];
}

final class TMDbStateErrorWithoutAccountDetailsCache extends TMDbState {
  final CustomErrorEntity error;

  const TMDbStateErrorWithoutAccountDetailsCache(this.error);

  @override
  List<Object?> get props => [error];
}

final class TMDbStateSignedOut extends TMDbState {
  const TMDbStateSignedOut();

  @override
  List<Object?> get props => [];
}

final class TMDbStateSigningOutError extends TMDbState {
  final CustomErrorEntity error;

  const TMDbStateSigningOutError(this.error);

  @override
  List<Object?> get props => [error];
}
