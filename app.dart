import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme/app_theme.dart';
import 'features/home/home_screen.dart';
import 'features/services/services_screen.dart';
import 'features/services/service_detail_screen.dart';
import 'features/projects/projects_screen.dart';
import 'features/projects/project_detail_screen.dart';
import 'features/booking/booking_screen.dart';
import 'features/booking/booking_success_screen.dart';
import 'features/reviews/reviews_screen.dart';
import 'features/contact/contact_screen.dart';
import 'features/admin/admin_login_screen.dart';
import 'features/admin/admin_dashboard_screen.dart';
import 'features/admin/manage_services_screen.dart';
import 'features/admin/manage_projects_screen.dart';
import 'features/admin/add_project_screen.dart';
import 'features/admin/manage_bookings_screen.dart';
import 'features/admin/manage_comments_screen.dart';
import 'features/admin/manage_reviews_screen.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/services', builder: (context, state) => const ServicesScreen()),
    GoRoute(path: '/services/:id', builder: (context, state) => ServiceDetailScreen(serviceId: state.pathParameters['id']!)),
    GoRoute(path: '/projects', builder: (context, state) => const ProjectsScreen()),
    GoRoute(path: '/projects/:id', builder: (context, state) => ProjectDetailScreen(projectId: state.pathParameters['id']!)),
    GoRoute(path: '/booking', builder: (context, state) => const BookingScreen()),
    GoRoute(path: '/booking/success', builder: (context, state) => const BookingSuccessScreen()),
    GoRoute(path: '/reviews', builder: (context, state) => const ReviewsScreen()),
    GoRoute(path: '/contact', builder: (context, state) => const ContactScreen()),
    GoRoute(path: '/admin/login', builder: (context, state) => const AdminLoginScreen()),
    GoRoute(path: '/admin/dashboard', builder: (context, state) => const AdminDashboardScreen()),
    GoRoute(path: '/admin/services', builder: (context, state) => const ManageServicesScreen()),
    GoRoute(path: '/admin/projects', builder: (context, state) => const ManageProjectsScreen()),
    GoRoute(path: '/admin/projects/add', builder: (context, state) => const AddProjectScreen()),
    GoRoute(path: '/admin/bookings', builder: (context, state) => const ManageBookingsScreen()),
    GoRoute(path: '/admin/comments', builder: (context, state) => const ManageCommentsScreen()),
    GoRoute(path: '/admin/reviews', builder: (context, state) => const ManageReviewsScreen()),
  ],
);

class EliteHomeRepairsApp extends StatelessWidget {
  const EliteHomeRepairsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Elite Home Repairs & Decor',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: _router,
    );
  }
}
