import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:meditamos/src/presentation/utils/routing/app_router.dart';
import 'package:meditamos/src/presentation/utils/theme/app_theme.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class MeditamosApp extends StatelessWidget {
  const MeditamosApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //Wrap the app with ProviderScope to make accesible riverpod providers to the app
    //ProviderScope is a widget that stores the state of all the providers we create
    return const ProviderScope(
      child: MeditamosMaterialApp(),
    );
  }

  //Initialization logic. Here we put the logic that must be called in main.dart before running the app.
  static Future<void> initializeApp() async {
    //Initialize Hive database
    final documentsDirectory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(documentsDirectory.path);
  }
}

class MeditamosMaterialApp extends ConsumerWidget {
  const MeditamosMaterialApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode themeMode = ref.watch(AppTheme.themeModeProvider);
    final GoRouter appRouter = ref.watch(AppRouter.provider);

    return MaterialApp.router(
      title: 'Meditamos',
      debugShowCheckedModeBanner: false,
      //Theme
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      //Routing
      routeInformationProvider: appRouter.routeInformationProvider,
      routeInformationParser: appRouter.routeInformationParser,
      routerDelegate: appRouter.routerDelegate,
    );
  }
}
