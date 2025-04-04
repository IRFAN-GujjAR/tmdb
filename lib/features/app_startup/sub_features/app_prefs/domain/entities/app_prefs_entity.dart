import 'package:equatable/equatable.dart';
import 'package:tmdb/core/ui/theme/theme_utils.dart';

class AppPrefsEntity extends Equatable {
  final bool appStartedForFirstTime;
  final AppThemes appTheme;

  AppPrefsEntity(
      {required this.appStartedForFirstTime, required this.appTheme});

  @override
  List<Object?> get props => [appStartedForFirstTime, appTheme];
}
