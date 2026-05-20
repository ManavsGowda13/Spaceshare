import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/space_login.dart';
import 'screens/space_dashboard.dart';
import 'screens/space_admin.dart';

void main() => runApp(const SpaceShareApp());

class SpaceShareApp extends StatelessWidget {
  const SpaceShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D1117),
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SpaceLogin(),
        '/dashboard': (context) => const SpaceDashboard(),
        '/admin': (context) => const SpaceAdmin(),
      },
    );
  }
}
