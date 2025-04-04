import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/ui/widgets/custom_error_widget.dart';
import 'package:tmdb/core/ui/widgets/custom_filled_button_widget.dart';
import 'package:tmdb/core/ui/widgets/loading_widget.dart';
import 'package:tmdb/features/app_startup/presentation/bloc/app_startup_bloc.dart';
import 'package:tmdb/features/app_startup/presentation/providers/app_startup_provider.dart';

class AppStartupPage extends StatelessWidget {
  const AppStartupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppStartupBloc, AppStartupState>(
        listener: (context, state) {
          context.read<AppStartupProvider>().handleBlocState(context, state);
        },
        builder: (context, state) {
          switch (state) {
            case AppStartupStateRemoteConfigLoaded():
              if (!state.remoteConfig.appVersion.isRequiredVersionInstalled)
                return Center(
                  child: CustomFilledButtonWidget(
                    onPressed: () {
                      context.read<AppStartupProvider>().updateApp;
                    },
                    child: Text('Update App'),
                  ),
                );
            case AppStartupStateRemoteConfigError():
              return CustomErrorWidget(
                error: state.error,
                onPressed: () {
                  context.read<AppStartupBloc>().add(
                    AppStartupEvent.LoadRemoteConfig,
                  );
                },
              );
            case AppStartupStateUserSessionError():
              return CustomErrorWidget(
                error: state.error,
                onPressed: () {
                  context.read<AppStartupBloc>().add(
                    AppStartupEvent.LoadUserSession,
                  );
                },
              );
            default:
              return LoadingWidget();
          }
          return LoadingWidget();
        },
      ),
    );
  }
}
