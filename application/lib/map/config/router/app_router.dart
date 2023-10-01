import 'package:application/map/presentation/views/create_view/create_view.dart';
import 'package:application/map/presentation/views/list_task_view/list_task_view.dart';
import 'package:application/map/presentation/views/update_view/update_view.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

GoRouter appRouter(GlobalKey<NavigatorState> navigatorKey) {
  return GoRouter(navigatorKey: navigatorKey, routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        return "/list";
      },
      builder: (context, state) {
        return const ListTaskView();
      },
    ),
    GoRoute(
        path: '/create',
        builder: (context, state) => const CreateViewWrapper()),
    GoRoute(
        path: '/update/:id',
        builder: (context, state) {
          String? id = state.pathParameters["id"];
          return UpdateViewWrapper(taskId: int.parse(id ?? "-1"));
        }),
    GoRoute(
      path: '/list',
      builder: (context, state) => const ListTaskView(),
    )
  ]);
}
