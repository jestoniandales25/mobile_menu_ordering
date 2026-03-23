import 'package:flutter/material.dart';
import 'package:mobile_menu_ordering/blocs/cart_bloc.dart';
import 'package:mobile_menu_ordering/blocs/food_bloc.dart';
import 'package:mobile_menu_ordering/core/constants/app_colors.dart';
import 'package:mobile_menu_ordering/data/repositories/food_repository.dart';
import 'package:mobile_menu_ordering/ui/screens/cart_screen.dart';
import 'package:mobile_menu_ordering/ui/screens/dashboard_screen.dart';
import 'package:mobile_menu_ordering/ui/screens/food_detail_screen.dart';
import 'package:mobile_menu_ordering/ui/screens/splash_screen.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FoodBloc(FoodRepository())..loadFoods(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartBloc(),
        ),
        // ✅ Theme toggle
        ChangeNotifierProvider(
          create: (_) => ThemeBloc(),
        ),
      ],
      child: const FoodApp(),
    ),
  );
}

// Simple theme bloc
class ThemeBloc extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  void toggle() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

class FoodApp extends StatelessWidget {
  const FoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeBloc>().isDark;

    return MaterialApp(
      title: 'Food Order',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.lightBackground,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: AppColors.lightSurface,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBackground,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: AppColors.darkSurface,
        ),
        useMaterial3: true,
      ),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/detail': (context) => const FoodDetailScreen(),
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}