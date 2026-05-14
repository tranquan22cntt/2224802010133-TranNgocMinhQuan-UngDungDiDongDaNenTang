import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/audio_provider.dart';
import 'providers/playlist_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AudioProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PlaylistProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Simple Music App',
        theme: ThemeData.dark(),
        home: const HomeScreen(),
      ),
    );
  }
}