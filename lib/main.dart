import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/dpi/di.dart';
import 'package:movie/features/app_section/app_section.dart';
import 'package:movie/features/details/presentation/view/details_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          routes: {
            DetailsScreen.routeName: (_) => const DetailsScreen(),
          },
          home: AppSection(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
