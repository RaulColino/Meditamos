import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meditamos/src/presentation/utils/routing/app_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.replaceNamed(AppRoutes.homeScreen.name),
              child: const Text("home"),
            ),
            ElevatedButton(
              onPressed: () =>
                  context.pushNamed(AppRoutes.onboardingScreen.name),
              child: const Text("onboarding"),
            ),
            ElevatedButton(
              onPressed: () => context.pushNamed(
                AppRoutes.audioScreen.name,
                params: {'title': "pid"},
              ),
              child: const Text("audio"),
            ),
            ElevatedButton(
              onPressed: () => context.pushNamed(AppRoutes.musicPlaylistScreen.name),
              child: const Text("playlist"),
            ),
          ],
        ),
      ),
    );
  }
}
