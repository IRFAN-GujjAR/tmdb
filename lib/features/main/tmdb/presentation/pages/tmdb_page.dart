import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/ui/ui_utl.dart';
import 'package:tmdb/core/ui/widgets/custom_body_widget.dart';
import 'package:tmdb/core/ui/widgets/custom_error_widget.dart';
import 'package:tmdb/core/ui/widgets/loading_widget.dart';
import 'package:tmdb/features/app_startup/sub_features/user_session/presentation/providers/user_session_provider.dart';
import 'package:tmdb/features/main/tmdb/presentation/blocs/tmdb_bloc.dart';
import 'package:tmdb/features/main/tmdb/presentation/blocs/tmdb_event.dart';
import 'package:tmdb/features/main/tmdb/presentation/widgets/tmdb_widget.dart';

import '../../../../login/presentation/blocs/login_status/login_status_bloc.dart';
import '../blocs/tmdb_state.dart';

class TMDbPage extends StatelessWidget {
  const TMDbPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBodyWidget(
        child: BlocConsumer<TMDbBloc, TMDbState>(
          listener: (context, state) {
            if (state is TMDbStateErrorWithAccountDetailsCache) {
              UIUtl.showSnackBar(context, msg: state.error.error.errorMessage);
            } else if (state is TMDbStateSignedOut) {
              context.read<UserSessionProvider>().reset;
              context.read<LoginStatusBloc>().add(LoginStatusEventLogout());
            }
          },
          builder: (context, state) {
            switch (state) {
              case TMDbStateLoadingAccountDetails():
              case TMDbStateSigningOut():
                return LoadingWidget();
              case TMDbStateAccountDetailsLoaded():
                return TMDbbWidget(accountDetails: state.accountDetails);
              case TMDbStateErrorWithAccountDetailsCache():
                return TMDbbWidget(accountDetails: state.accountDetails);
              case TMDbStateErrorWithoutAccountDetailsCache():
                return CustomErrorWidget(
                  error: state.error,
                  onPressed: () {
                    context.read<TMDbBloc>().add(
                      TMDbEventLoadAccountDetails(
                        context
                            .read<UserSessionProvider>()
                            .userSession
                            .sessionId,
                      ),
                    );
                  },
                );
              case TMDbStateAccountDetailsEmpty():
                return const TMDbbWidget();
              case TMDbStateSignedOut():
                return const TMDbbWidget();
              case TMDbStateSigningOutError():
                return CustomErrorWidget(
                  error: state.error,
                  onPressed: () {
                    context.read<TMDbBloc>().add(const TMDbEventSignOut());
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
