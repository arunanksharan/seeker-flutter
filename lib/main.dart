import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:seeker_flutter/config/router.dart';
import 'package:seeker_flutter/data/blocs/auth/auth_bloc.dart';
import 'package:seeker_flutter/data/blocs/profile/profile_bloc.dart';
import 'package:seeker_flutter/data/services/api_client.dart';
import 'package:seeker_flutter/data/services/auth_service.dart';
import 'package:seeker_flutter/data/services/profile_service.dart';
import 'package:seeker_flutter/theme/app_theme.dart';
import 'package:seeker_flutter/utils/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize logger
  setupLogger();
  logInfo('Starting Seeker Flutter App');
  
  try {
    // Initialize Firebase
    await Firebase.initializeApp();
    logInfo('Firebase initialized successfully');
  } catch (e) {
    logError('Firebase initialization failed', e);
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create API client
    final apiClient = ApiClient();
    
    // Create services
    final authService = AuthService(apiClient);
    final profileService = ProfileService(apiClient);
    
    // Create blocs
    final authBloc = AuthBloc(authService: authService);
    final profileBloc = ProfileBloc(profileService: profileService);
    
    // Create router
    final appRouter = AppRouter(
      authBloc: authBloc,
      profileBloc: profileBloc,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => authBloc),
        BlocProvider<ProfileBloc>(create: (context) => profileBloc),
      ],
      child: MaterialApp.router(
        title: 'Seeker',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light, // Default to light theme
        routerConfig: appRouter.router,
        debugShowCheckedModeBanner: false,
      ),
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
