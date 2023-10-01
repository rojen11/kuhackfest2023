import 'package:application/map/config/router/app_router.dart';
import 'package:application/map/config/themes/app_theme.dart';
import 'package:application/map/data/repositories/database_repository_impl.dart';
import 'package:application/map/presentation/cubits/task/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => DatabaseRepositoryImpl(),
      child: Builder(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => TaskCubit(
                    databaseRepository: context.read<DatabaseRepositoryImpl>())
                  ..getAllTasks(),
              )
            ],
            child: MaterialApp.router(
              routerConfig: appRouter(navigatorKey),
              theme: AppTheme.dark,
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    );
  }
}
