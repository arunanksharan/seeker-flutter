import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seeker_flutter/data/blocs/auth/auth_bloc.dart';
import 'package:seeker_flutter/data/blocs/auth/auth_state.dart';
import 'package:seeker_flutter/data/blocs/profile/profile_bloc.dart';
import 'package:seeker_flutter/data/blocs/profile/profile_event.dart';
import 'package:seeker_flutter/data/blocs/profile/profile_state.dart';
import 'package:seeker_flutter/presentation/screens/auth/login_screen.dart';
import 'package:seeker_flutter/presentation/screens/auth/otp_verification_screen.dart';
import 'package:seeker_flutter/presentation/screens/auth/registration_screen.dart';
import 'package:seeker_flutter/presentation/screens/home/home_screen.dart';
import 'package:seeker_flutter/presentation/screens/profile/profile_creation_screen.dart';
import 'package:seeker_flutter/presentation/screens/profile/profile_screen.dart';
import 'package:seeker_flutter/presentation/screens/splash_screen.dart';
import 'package:seeker_flutter/utils/logger.dart';

/// Router configuration for the app
class AppRouter {
  final AuthBloc _authBloc;
  final ProfileBloc _profileBloc;

  AppRouter({
    required AuthBloc authBloc,
    required ProfileBloc profileBloc,
  })  : _authBloc = authBloc,
        _profileBloc = profileBloc;

  /// Creates a GoRouter configuration for the app
  GoRouter get router => GoRouter(
        routes: _routes,
        initialLocation: '/splash',
        redirect: _guardedRoutes,
        debugLogDiagnostics: true,
        refreshListenable: GoRouterRefreshStream(_authBloc.stream),
      );

  /// Middleware for redirecting based on auth state
  String? _guardedRoutes(BuildContext context, GoRouterState state) {
    // Allow access to splash screen always
    if (state.matchedLocation == '/splash') {
      return null;
    }

    final authState = _authBloc.state;
    final isAuthenticated = authState is AuthAuthenticated;
    final isOnboardingRoute =
        state.matchedLocation.startsWith('/auth') ||
        state.matchedLocation == '/splash';

    // If user isn't authenticated and trying to access a protected route,
    // redirect to login
    if (!isAuthenticated && !isOnboardingRoute) {
      logInfo('Redirecting to login from ${state.matchedLocation}');
      return '/auth/login';
    }

    // If user is authenticated and trying to access an onboarding route,
    // check if they have a profile
    if (isAuthenticated && isOnboardingRoute) {
      // Check if we need to create a profile
      if (_profileBloc.state is ProfileNotExists) {
        logInfo('Redirecting to profile creation from ${state.matchedLocation}');
        return '/profile/create';
      }
      
      // If profile exists or we're loading it, redirect to home
      logInfo('Redirecting to home from ${state.matchedLocation}');
      return '/home';
    }

    // Special case for profile creation
    if (isAuthenticated && 
        state.matchedLocation != '/profile/create' && 
        _profileBloc.state is ProfileNotExists) {
      logInfo('Redirecting to profile creation from ${state.matchedLocation}');
      return '/profile/create';
    }

    // Default: don't redirect
    return null;
  }

  /// App routes
  List<RouteBase> get _routes => [
        // Splash screen
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashScreen(),
        ),

        // Auth routes
        GoRoute(
          path: '/auth',
          builder: (context, state) => const LoginScreen(),
          routes: [
            GoRoute(
              path: 'login',
              builder: (context, state) => const LoginScreen(),
            ),
            GoRoute(
              path: 'register',
              builder: (context, state) => const RegistrationScreen(),
            ),
            GoRoute(
              path: 'verify-otp',
              builder: (context, state) {
                // Extract mobile and type from state
                final mobile = state.queryParameters['mobile'] ?? '';
                final type = state.queryParameters['type'] ?? 'login';

                return OtpVerificationScreen(
                  mobile: mobile,
                  type: type,
                );
              },
            ),
          ],
        ),

        // Home route
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),

        // Profile routes
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
          routes: [
            GoRoute(
              path: 'create',
              builder: (context, state) => const ProfileCreationScreen(),
            ),
            GoRoute(
              path: 'edit',
              builder: (context, state) => const ProfileScreen(isEditing: true),
            ),
          ],
        ),
      ];
}

/// Custom RefreshListenable for GoRouter that listens to a Bloc's stream
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
