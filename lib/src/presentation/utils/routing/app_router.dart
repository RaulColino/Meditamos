import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meditamos/src/domain/entities/audio.dart';
import 'package:meditamos/src/domain/entities/video.dart';
import 'package:meditamos/src/presentation/screens/audio/audio_screen.dart';
import 'package:meditamos/src/presentation/screens/meditation/meditation_screen.dart';
import 'package:meditamos/src/presentation/screens/music_playlist/music_playlist_screen.dart';
import 'package:meditamos/src/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:meditamos/src/presentation/screens/splash/splash_screen.dart';
import 'package:meditamos/src/presentation/screens/home/home_screen.dart';
import 'package:meditamos/src/presentation/screens/video/video_screen.dart';

//Careful GoRouter will look up the route by name in a case-insensitive way so don't put Upercase letters because it won't work
enum AppRoutes {
  splashScreen,
  onboardingScreen,
  homeScreen,
  meditationScreen,
  videoScreen,
  audioScreen,
  musicPlaylistScreen,
}

class AppRouter {
  //AppRouter._(); //Factory constructor but do we really need it?

  //Routing for Screens
  static final _goRouter = GoRouter(
    initialLocation: "/splash",
    debugLogDiagnostics: true, //Don't enable this in production
    routes: [
      GoRoute(
        name: AppRoutes.splashScreen.name,
        path: "/splash",
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        name: AppRoutes.onboardingScreen.name,
        path: "/onboarding",
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: const OnboardingScreen(),
        ),
      ),
      GoRoute(
        name: AppRoutes.homeScreen.name,
        path: "/home",
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: HomeScreen(),
        ),
      ),
      GoRoute(
        name: AppRoutes.meditationScreen.name,
        path: "/meditation",
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: MeditationScreen(),
        ),
      ),
      GoRoute(
        name: AppRoutes.audioScreen.name,
        path: "/audio",
        pageBuilder: (context, state) {
          Audio audio = state.extra! as Audio;
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: AudioScreen(audio: audio),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.musicPlaylistScreen.name,
        path: "/music-playlist",
        pageBuilder: (context, state) {
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: MusicPlaylistScreen(),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.videoScreen.name,
        path: "/video",
        pageBuilder: (context, state) {
          Video video = state.extra! as Video;
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: VideoScreen(video: video),
          );
        },
      ),
    ],
  );

  //Transitions
  static CustomTransitionPage<dynamic> buildPageWithFadeTransition({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<dynamic>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }

  //GoRouter provider   //We use a Riverpod provider in case we need to handle states like login state or something else
  static final Provider<GoRouter> provider =
      Provider<GoRouter>((_) => _goRouter);
}
