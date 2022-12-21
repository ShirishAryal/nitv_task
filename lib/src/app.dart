// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:nitv_task_repository/nitv_task_repository.dart';

// import 'router/router.dart';

// class NewsApp extends StatelessWidget {
//   final NitvTaskRepository nitvTaskRepository;
//   const NewsApp({super.key, required this.nitvTaskRepository});

//   @override
//   Widget build(BuildContext context) {
//     return RepositoryProvider.value(
//       value: nitvTaskRepository,
//       child: const NewsAppView(),
//     );
//   }
// }

// class NewsAppView extends StatelessWidget {
//   const NewsAppView({super.key});
//   static final NitvTaskRouter _appRouter = NitvTaskRouter();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: "/",
//       onGenerateRoute: NitvTaskRouter.generateRoute,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitv_task_repository/nitv_task_repository.dart';

import 'router/router.dart';

class NewsApp extends StatelessWidget {
  final NitvTaskRepository nitvTaskRepository;
  const NewsApp({super.key, required this.nitvTaskRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: nitvTaskRepository,
      child: const NewsAppView(),
    );
  }
}

class NewsAppView extends StatelessWidget {
  const NewsAppView({super.key});
  static final NitvTaskRouter _appRouter = NitvTaskRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      onGenerateRoute: _appRouter.generateRoute,
    );
  }
}
