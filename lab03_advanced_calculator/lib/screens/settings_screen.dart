import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/history_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    final history = Provider.of<HistoryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text("APPEARANCE", style: TextStyle(color: Color(0xFF4ECDC4), fontWeight: FontWeight.bold)),
          ListTile(
            title: const Text("Theme Mode"),
            trailing: DropdownButton<ThemeMode>(
              value: theme.themeMode,
              onChanged: (m) => theme.setTheme(m!),
              items: const [
                DropdownMenuItem(value: ThemeMode.system, child: Text("System")),
                DropdownMenuItem(value: ThemeMode.light, child: Text("Light")),
                DropdownMenuItem(value: ThemeMode.dark, child: Text("Dark")),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text("Clear History", style: TextStyle(color: Colors.red)),
            onTap: () => history.clearHistory(),
          ),
        ],
      ),
    );
  }
}