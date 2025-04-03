import 'package:flutter/material.dart';
import 'package:seeker_flutter/theme/app_theme.dart';
import 'package:seeker_flutter/utils/logger.dart'; // Import the logger

void main() {
  // Optional: Add any necessary initialization here
  // WidgetsFlutterBinding.ensureInitialized(); 
  // await Firebase.initializeApp(...); // If using Firebase

  // Setup logging
  appLogger.i('Application Starting...');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seeker Flutter App',
      theme: AppTheme.lightTheme, // Apply the light theme
      // darkTheme: AppTheme.darkTheme, // Uncomment if you have a dark theme
      // themeMode: ThemeMode.system, // Or ThemeMode.light, ThemeMode.dark
      home: const PlaceholderScreen(), // Start with a placeholder screen
      debugShowCheckedModeBanner: false, // Disable the debug banner
    );
  }
}

// A simple placeholder screen to start with
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seeker App'),
      ),
      body: Center(
        child: Text(
          'Welcome to Seeker!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
