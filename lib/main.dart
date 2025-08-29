import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/app_strings.dart';
import 'core/store/app_state.dart';
import 'core/store/app_reducer.dart';
import 'core/di/service_locator.dart';
import 'core/routes/app_router.dart';
import 'core/constants/app_theme.dart';
import 'core/middleware/auth_middleware.dart';
import 'core/middleware/persistence_middleware.dart';
import 'core/middleware/persistence_bootstrap.dart';
import 'core/widgets/auth_wrapper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(options: currentPlatform);
  } catch (e) {
    debugPrint("e $e");
  }

  // Initialize service locator
  await ServiceLocator.init();

  // Create Redux store
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [
      LoggingMiddleware.printer().call,
      AuthMiddleware().call,
      PersistenceMiddleware(ServiceLocator.localStorageService).call,
    ],
  );

  // Bootstrap persisted data (cart and wishlist)
  await bootstrapPersistence(store);

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return StoreConnector<AppState, bool>(
            converter: (store) => store.state.isDarkMode,
            builder: (context, isDarkMode) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: AppStrings.appName,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: ThemeMode.system,
                initialRoute: AppRouter.initial,
                onGenerateRoute: AppRouter.onGenerateRoute,
                builder: (context, child) {
                  return AuthWrapper(child: child!);
                },
              );
            },
          );
        },
      ),
    );
  }
}
