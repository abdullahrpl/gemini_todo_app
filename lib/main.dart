import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini_todo_app/mediator/mediator_data.dart';
import 'package:get/get.dart';
import 'package:lite_storage/lite_storage.dart';
import 'profile/profile_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LiteStorage.init();
  Gemini.init(apiKey: 'AIzaSyDvkjCn8GAzNex5DJVeKsu9Wjyyvzu5RDk');
  _loadInitialTheme();
  runApp(_ScheduleApp());
}

void _loadInitialTheme() {
  final savedTheme = LiteStorage.read('theme_mode');
  if (savedTheme != null) {
    switch (savedTheme) {
      case 'light':
        ProfileController.themeMode.value = ThemeMode.light;
        break;
      case 'dark':
        ProfileController.themeMode.value = ThemeMode.dark;
        break;
      default:
        ProfileController.themeMode.value = ThemeMode.system;
    }
  }
}

class _ScheduleApp extends StatelessWidget {
  final Mediator mediator = Mediator();

  @override
  Widget build(BuildContext context) {
    Mediator.instance = mediator;
    return Obx(
      () => GetMaterialApp(
        title: Mediator.title,
        debugShowCheckedModeBanner: false,
        theme: _buildLightTheme(),
        darkTheme: _buildDarkTheme(),
        themeMode: ProfileController.themeMode.value,
        initialRoute: Mediator.initialRoute,
        getPages: Mediator.getPages,
      ),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFFFFFFF), // Solid White
      primaryColor: const Color(0xFFD32F2F), // Red 700
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFD32F2F),
        brightness: Brightness.light,
        primary: const Color(0xFFD32F2F),
        onPrimary: Colors.white,
        secondary: const Color(0xFFF44336), // Red 500
        surface: Colors.white,
      ),
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFFD32F2F), // Red 700
        iconTheme: IconThemeData(color: Color(0xFFD32F2F)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xFFD32F2F),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFFAFAFA), // Very light grey
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFEEEEEE))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFEEEEEE))),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 2),
        ),
        labelStyle: const TextStyle(color: Color(0xFF757575)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD32F2F),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFEEEEEE)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF333333),
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      dividerTheme: const DividerThemeData(color: Color(0xFFEEEEEE), thickness: 1),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF121212), // Dark Grey
      primaryColor: const Color(0xFFE53935), // Red 600
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFE53935),
        brightness: Brightness.dark,
        primary: const Color(0xFFE53935),
        onPrimary: Colors.white,
        secondary: const Color(0xFFEF5350), // Red 400
        surface: const Color(0xFF1E1E1E),
        onSurface: const Color(0xFFF5F5F5),
      ),
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF121212),
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xFFE53935),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF333333))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF333333))),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE53935), width: 2),
        ),
        labelStyle: const TextStyle(color: Color(0xFFBDBDBD)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE53935),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E1E1E),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF333333)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFFEEEEEE),
        contentTextStyle: const TextStyle(color: Color(0xFF121212)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      dividerTheme: const DividerThemeData(color: Color(0xFF333333), thickness: 1),
    );
  }
}