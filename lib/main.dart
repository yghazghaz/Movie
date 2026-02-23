import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie/core/di/di.dart';
import 'package:movie/core/utils/app_hive.dart';
import 'package:movie/features/app_section/app_section.dart';
import 'package:movie/features/watch_list/data/api/watch_list_local_datasource.dart';
import 'package:movie/features/watch_list/data/models/watch_list_model.dart';
import 'package:movie/features/watch_list/data/repo/repositories_impl/witch_list_repo_impl.dart';
import 'package:movie/features/watch_list/domain/use_cases/watch_list_use_case.dart';
import 'package:movie/features/watch_list/presentation/view_model/watch_list_cubit.dart';

import 'features/details/presentation/view/details_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(WatchListModelAdapter());

  await Hive.openBox<WatchListModel>(AppHive.watchListBox);

  final localDataSource = WatchListLocalDataSourceImpl();

  final repository = WatchListRepositoryImpl(localDataSource);
  configureDependencies();
  runApp(MovieApp(repository: repository));
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key, required this.repository});
  final WatchListRepositoryImpl repository;


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => WatchListCubit(
            getWatchListUseCase: GetWatchListUseCase(repository),
            toggleWatchListUseCase: ToggleWatchListUseCase(repository),
            removeFromWatchListUseCase: RemoveFromWatchListUseCase(repository),
            isMovieSavedUseCase: IsMovieSavedUseCase(repository),
          ),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            routes: {
              DetailsScreen.routeName: (context) => const DetailsScreen(),
            },
            debugShowCheckedModeBanner: false,
            home: const AppSection(),
          );
        },
      ),
    );
  }
}
