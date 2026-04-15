import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:red_edge_app/features/admin/presentation/screens/admin_dashboard_screen.dart';
import 'package:red_edge_app/features/admin/presentation/screens/admin_job_detail_screen.dart';
import 'package:red_edge_app/features/admin/presentation/screens/create_job_screen.dart';
import 'package:red_edge_app/features/admin/presentation/screens/edit_job_screen.dart';
import 'package:red_edge_app/features/admin/presentation/screens/installer_management_screen.dart';
import 'package:red_edge_app/features/admin/presentation/screens/checklist_management_screen.dart';
import 'package:red_edge_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:red_edge_app/features/auth/presentation/screens/login_screen.dart';
import 'package:red_edge_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:red_edge_app/features/auth/presentation/screens/welcome_screen.dart';
import 'package:red_edge_app/features/jobs/presentation/screens/job_detail_screen.dart';
import 'package:red_edge_app/features/jobs/presentation/screens/job_list_screen.dart';
import 'package:red_edge_app/features/photos/presentation/screens/camera_screen.dart';
import 'package:red_edge_app/features/photos/presentation/screens/photo_review_screen.dart';
import 'package:red_edge_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:red_edge_app/core/constants/app_colors.dart';

/// Bridges Riverpod auth state changes → GoRouter.refresh via ChangeNotifier.
class _AuthRefreshNotifier extends ChangeNotifier {
  _AuthRefreshNotifier(Ref ref) {
    ref.listen<AuthState>(authProvider, (_, __) {
      notifyListeners();
    });
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = _AuthRefreshNotifier(ref);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final path = state.uri.path;

      // While checking stored token, show splash
      if (authState.isInitializing) {
        return path == '/splash' ? null : '/splash';
      }

      // Done initializing — leave splash
      if (path == '/splash') {
        if (authState.isLoggedIn) {
          final user = authState.user;
          if (user != null && user.isAdmin) return '/admin';
          return '/jobs';
        }
        return '/welcome';
      }

      final isLoggedIn = authState.isLoggedIn;
      final isAuthRoute =
          path == '/welcome' || path == '/login' || path == '/signup';

      if (!isLoggedIn && !isAuthRoute) return '/welcome';
      if (isLoggedIn && isAuthRoute) {
        final user = authState.user;
        if (user != null && user.isAdmin) return '/admin';
        return '/jobs';
      }
      return null;
    },
    routes: [
      // Splash — neutral loading shown during auth check
      GoRoute(
        path: '/splash',
        pageBuilder: (ctx, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const _SplashScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),

      // Welcome / Role Selection
      GoRoute(
        path: '/welcome',
        pageBuilder: (ctx, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const WelcomeScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),

      // Login
      GoRoute(
        path: '/login',
        pageBuilder: (ctx, state) {
          final role = state.uri.queryParameters['role'] ?? 'installer';
          return CustomTransitionPage(
            key: state.pageKey,
            child: LoginScreen(role: role),
            transitionsBuilder: _fadeTransition,
          );
        },
      ),

      // Signup
      GoRoute(
        path: '/signup',
        pageBuilder: (ctx, state) {
          final role = state.uri.queryParameters['role'] ?? 'installer';
          return CustomTransitionPage(
            key: state.pageKey,
            child: SignupScreen(role: role),
            transitionsBuilder: _fadeTransition,
          );
        },
      ),

      // Bottom nav shell
      ShellRoute(
        builder: (ctx, state, child) => child,
        routes: [
          GoRoute(
            path: '/jobs',
            pageBuilder: (ctx, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const JobListScreen(),
              transitionsBuilder: _fadeSlideTransition,
            ),
          ),
          GoRoute(
            path: '/admin',
            pageBuilder: (ctx, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const AdminDashboardScreen(),
              transitionsBuilder: _fadeSlideTransition,
            ),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (ctx, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const SettingsScreen(),
              transitionsBuilder: _fadeSlideTransition,
            ),
          ),
        ],
      ),

      // Admin full-screen routes
      GoRoute(
        path: '/admin/create-job',
        pageBuilder: (ctx, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const CreateJobScreen(),
          transitionsBuilder: _slideUpTransition,
        ),
      ),
      // Installer create-job route (reuses same screen)
      GoRoute(
        path: '/jobs/create',
        pageBuilder: (ctx, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const CreateJobScreen(),
          transitionsBuilder: _slideUpTransition,
        ),
      ),
      GoRoute(
        path: '/admin/edit-job/:id',
        pageBuilder: (ctx, state) => CustomTransitionPage(
          key: state.pageKey,
          child: EditJobScreen(jobId: state.pathParameters['id']!),
          transitionsBuilder: _slideUpTransition,
        ),
      ),
      GoRoute(
        path: '/admin/installers',
        pageBuilder: (ctx, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const InstallerManagementScreen(),
          transitionsBuilder: _slideTransition,
        ),
      ),
      GoRoute(
        path: '/admin/checklists',
        pageBuilder: (ctx, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ChecklistManagementScreen(),
          transitionsBuilder: _slideTransition,
        ),
      ),
      GoRoute(
        path: '/admin/jobs/:id',
        pageBuilder: (ctx, state) => CustomTransitionPage(
          key: state.pageKey,
          child: AdminJobDetailScreen(jobId: state.pathParameters['id']!),
          transitionsBuilder: _slideTransition,
        ),
      ),

      // Full-screen routes (no bottom nav)
      GoRoute(
        path: '/jobs/:id',
        pageBuilder: (ctx, state) => CustomTransitionPage(
          key: state.pageKey,
          child: JobDetailScreen(
            jobId: state.pathParameters['id']!,
          ),
          transitionsBuilder: _slideTransition,
        ),
      ),
      GoRoute(
        path: '/jobs/:id/steps/:stepId/camera',
        pageBuilder: (ctx, state) => CustomTransitionPage(
          key: state.pageKey,
          child: CameraScreen(
            jobId: state.pathParameters['id']!,
            stepId: state.pathParameters['stepId']!,
          ),
          transitionsBuilder: _slideUpTransition,
        ),
      ),
      GoRoute(
        path: '/jobs/:id/steps/:stepId/photo-review',
        pageBuilder: (ctx, state) => CustomTransitionPage(
          key: state.pageKey,
          child: PhotoReviewScreen(
            args: state.extra as PhotoReviewArgs,
          ),
          transitionsBuilder: _slideTransition,
        ),
      ),
    ],
  );
});

Widget _fadeTransition(
  BuildContext ctx,
  Animation<double> anim,
  Animation<double> secAnim,
  Widget child,
) {
  return FadeTransition(
    opacity: CurvedAnimation(parent: anim, curve: Curves.easeIn),
    child: child,
  );
}

Widget _fadeSlideTransition(
  BuildContext ctx,
  Animation<double> anim,
  Animation<double> secAnim,
  Widget child,
) {
  return FadeTransition(
    opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
    child: child,
  );
}

Widget _slideTransition(
  BuildContext ctx,
  Animation<double> anim,
  Animation<double> secAnim,
  Widget child,
) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1.0, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
    child: child,
  );
}

Widget _slideUpTransition(
  BuildContext ctx,
  Animation<double> anim,
  Animation<double> secAnim,
  Widget child,
) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
    child: child,
  );
}

/// Neutral splash shown while auth state is being resolved on cold start.
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo container — replace child with Image.asset when logo is available
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Center(
                child:Image.asset(
    'assets/images/red_edge_app_logo.jpg', // apna image path yahan do
    width: 100, // optional
    height: 100, // optional
  ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Machine Guidance Installation',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 32),
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
