import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/history_provider.dart';
import 'history_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    final history = Provider.of<HistoryProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Settings", style: TextStyle(fontFamily: 'Roboto')),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
              "APPEARANCE",
              style: TextStyle(color: Color(0xFF4ECDC4), fontWeight: FontWeight.bold, letterSpacing: 1.2)
          ),
          const SizedBox(height: 8),
          ListTile(
            title: Text("Theme Mode", style: TextStyle(color: isDark ? Colors.white : Colors.black87)),
            trailing: DropdownButton<ThemeMode>(
              value: theme.themeMode,
              // SỬA LỖI MÀU NỀN MENU: Tự đổi theo theme
              dropdownColor: isDark ? const Color(0xFF2C2C2C) : Colors.white,
              elevation: 8,
              style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontFamily: 'Roboto'),
              underline: Container(height: 2, color: const Color(0xFF4ECDC4)),
              onChanged: (m) => theme.setTheme(m!),
              items: const [
                DropdownMenuItem(value: ThemeMode.system, child: Text("System")),
                DropdownMenuItem(value: ThemeMode.light, child: Text("Light")),
                DropdownMenuItem(value: ThemeMode.dark, child: Text("Dark")),
              ],
            ),
          ),

          const Divider(height: 40),
          const Text(
              "DATA & HISTORY",
              style: TextStyle(color: Color(0xFF4ECDC4), fontWeight: FontWeight.bold, letterSpacing: 1.2)
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.history, color: Color(0xFF4ECDC4)),
            title: Text("View Calculation History", style: TextStyle(color: isDark ? Colors.white : Colors.black87)),
            subtitle: const Text("See all your past calculations"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.redAccent),
            title: const Text("Clear History", style: TextStyle(color: Colors.redAccent)),
            onTap: () => _showDeleteConfirmation(context, history),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, HistoryProvider history) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // SỬA LỖI MÀU NỀN DIALOG: Tự đổi theo theme
        backgroundColor: isDark ? const Color(0xFF2C2C2C) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
            "Clear History?",
            style: TextStyle(color: isDark ? Colors.white : Colors.black)
        ),
        content: Text(
          "Bạn có chắc chắn muốn xóa toàn bộ lịch sử không?",
          style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("HỦY", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              history.clearHistory();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("History has been cleared!"),
                  backgroundColor: Color(0xFF4ECDC4),
                ),
              );
            },
            child: const Text("XÓA NGAY", style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}