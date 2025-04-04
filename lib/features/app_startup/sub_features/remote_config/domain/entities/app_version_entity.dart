import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class AppVersionEntity extends Equatable {
  @JsonKey(name: 'installed_version')
  final String installedVersion;
  @JsonKey(name: 'play_store_app_version')
  final String playStoreVersion;
  @JsonKey(name: 'min_required_android_app_version')
  final String minRequiredVersion;

  const AppVersionEntity({
    required this.installedVersion,
    required this.playStoreVersion,
    required this.minRequiredVersion,
  });

  bool get isRequiredVersionInstalled {
    final installedVersionParts =
        installedVersion.split('.').map(int.parse).toList();
    final requiredVersionParts =
        minRequiredVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < 3; i++) {
      if (installedVersionParts[i] < requiredVersionParts[i]) {
        return false;
      }
    }

    return true;
  }

  @override
  List<Object?> get props => [
    installedVersion,
    playStoreVersion,
    minRequiredVersion,
  ];
}
