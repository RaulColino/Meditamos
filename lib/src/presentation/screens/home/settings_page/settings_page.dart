import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meditamos/src/presentation/utils/theme/app_theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("settings"),
          ThemeSettings(),
        ],
      ),
    );
  }
}

class ThemeSettings extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeNotifier = ref.read(AppTheme.themeModeProvider.notifier);

    return Column(
      children: [
        Text("Current theme: ${themeModeNotifier.state.name}"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (() => themeModeNotifier.state = ThemeMode.light),
              child: Text("light"),
            ),
            ElevatedButton(
              onPressed: (() => themeModeNotifier.state = ThemeMode.dark),
              child: Text("dark"),
            ),
            ElevatedButton(
              onPressed: (() => themeModeNotifier.state = ThemeMode.system),
              child: Text("system"),
            ),
          ],
        ),
      ],
    );
  }
}
