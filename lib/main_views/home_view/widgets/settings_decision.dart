import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../settings_view/settings_view.dart';
import '../../user_settings_view/user_settings_view.dart';
class SettingsDecision extends StatelessWidget {
  const SettingsDecision({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: SharedPreferences.getInstance().then((p) => p.getBool('isAdmin') ?? false),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data! ? const SettingsView() : const UserSettingsView();
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}