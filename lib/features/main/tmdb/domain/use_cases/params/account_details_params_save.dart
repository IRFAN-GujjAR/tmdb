import 'package:tmdb/features/main/tmdb/domain/entities/account_details_entity.dart';

final class AccountDetailsParamsSave {
  final int userId;
  final AccountDetailsEntity accountDetails;

  const AccountDetailsParamsSave({
    required this.userId,
    required this.accountDetails,
  });
}
