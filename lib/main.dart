import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meditamos/src/presentation/meditamos_app.dart';

void main() {
  //We must call the following method because we use await (inside  MeditamosApp.initializeApp()) before calling runApp()
  WidgetsFlutterBinding.ensureInitialized();
  //status bar must show correct color as the light theme uses a white appbar and the status bar icons are white by default
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
  //We must await for app initialization logic before running the app
  MeditamosApp.initializeApp(); 
  //Finally run the app
  runApp(const MeditamosApp());
}
