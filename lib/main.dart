import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:spotify/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotify/core/router/app_pages.dart';
import 'package:spotify/core/utils/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/core/injection/service_locator.dart';
import 'package:spotify/core/utils/functions/save_auth_state.dart';
import 'package:spotify/feature/splash/presentation/pages/splash.dart';
import 'package:spotify/feature/onBoarding/presentation/bloc/theme_cubit/theme_cubit.dart';
// import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(
  //   Get.isDarkMode
  //       ? SystemUiOverlayStyle(statusBarBrightness: Brightness.dark)
  //       : SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
  // );
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  final bool hasSeenOnboarding = await isFirstLaunch();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();

  runApp(MyApp(
    hasSeenonBoarding: hasSeenOnboarding,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.hasSeenonBoarding});

  final bool hasSeenonBoarding;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) {
            return WillPopScope(
              onWillPop: () async {
                // Return false to prevent the back button from popping the current route
                return false;
              },
              child: GetMaterialApp(
                  initialRoute: AppPages.initial,
                  getPages: AppPages.routes,
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: mode,
                  home: SplashPage(
                    hasSeenOnBording: hasSeenonBoarding,
                  )),
            );
          },
        ),
      ),
    );
  }
}
