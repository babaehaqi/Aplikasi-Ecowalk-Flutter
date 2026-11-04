import 'package:flutter/material.dart';
import 'package:tugas_1_copy/screens/splash_screen.dart';
import 'package:tugas_1_copy/screens/signin_screen.dart';
import 'package:tugas_1_copy/screens/signup_screen.dart';
import 'package:tugas_1_copy/screens/otp_phone_screen.dart';
import 'package:tugas_1_copy/screens/otp_email_screen.dart';
import 'package:tugas_1_copy/screens/recovery_phone_screen.dart';
import 'package:tugas_1_copy/screens/recovery_email_screen.dart';
import 'package:tugas_1_copy/screens/reset_password_screen.dart';
import 'package:tugas_1_copy/screens/user_profile_screen.dart';
import 'package:tugas_1_copy/screens/account_settings_screen.dart';
import 'package:tugas_1_copy/screens/edit_profile_screen.dart';
import 'package:tugas_1_copy/screens/change_contact_screen.dart';
import 'package:tugas_1_copy/screens/update_password_screen.dart';
import 'package:tugas_1_copy/screens/delete_account_screen.dart';
import 'package:tugas_1_copy/screens/terms_screen.dart';
import 'package:tugas_1_copy/screens/about_us_screen.dart';
import 'package:tugas_1_copy/screens/privacy_policy_screen.dart';
import 'package:tugas_1_copy/models/ecowalk_profile.dart';
import 'package:tugas_1_copy/models/destination.dart';
import 'package:tugas_1_copy/models/recently_viewed_destinations.dart';
import 'package:tugas_1_copy/screens/home_screen.dart';
import 'package:tugas_1_copy/screens/destination_screens.dart';
import 'package:tugas_1_copy/screens/review_screens.dart';
import 'package:tugas_1_copy/screens/recommendation_screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EcowalkProfile.instance.load();
  await RecentlyViewedDestinations.load();
  runApp(const EcowalkApp());
}

class EcowalkApp extends StatelessWidget {
  const EcowalkApp({super.key});

  static const Color brandPrimaryColor = Color(0xFF1A6556);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecowalk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: brandPrimaryColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: brandPrimaryColor,
          primary: brandPrimaryColor,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/verificationWithNoHP': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final data = args is Map ? args : const {};
          return PhoneOtpScreen(
            destination: data['target'] as String?,
            isContactUpdate: data['purpose'] == 'change_phone',
          );
        },
        '/verificationWithEmail': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final data = args is Map ? args : const {};
          return EmailOtpScreen(
            destination: data['target'] as String?,
            isContactUpdate: data['purpose'] == 'change_email',
          );
        },
        '/forpassNoHp': (context) => const ForpassPhoneScreen(),
        '/forpassEmail': (context) => const ForpassEmailScreen(),
        '/changePass': (context) => const ChangePasswordScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/account_settings': (context) => const AccountSettingsScreen(),
        '/edit_profile': (context) => const EditProfileScreen(),
        '/change_phone': (context) => const ChangeContactScreen(isPhone: true),
        '/change_email': (context) => const ChangeContactScreen(isPhone: false),
        '/change_password': (context) => const UpdatePasswordScreen(),
        '/delete_account': (context) => const DeleteAccountScreen(),
        '/terms': (context) => const TermsScreen(),
        '/privacy': (context) => const PrivacyPolicyScreen(),
        '/about': (context) => const AboutUsScreen(),
        '/home': (context) => const HomeScreen(),
        '/weather': (context) => const WeatherDetailScreen(),
        '/travel_recap': (context) => const TravelRecapScreen(),
        '/categories': (context) => const CategoryListScreen(),
        '/recently_viewed': (context) => const RecentlyViewedScreen(),
        '/recommendations': (context) => const RecommendationSearchScreen(),
        '/route_recommendations': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final data = args is Map ? args : const {};
          return RecommendationRouteScreen(
            origin: data['origin'] as String? ?? 'Klapanunggal',
            destination:
                data['destination'] as String? ?? 'Trans Studio Cibubur',
          );
        },
        '/transport_comparison': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          return TransportComparisonScreen(mode: args as String? ?? 'ojol');
        },
        '/transit_details': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final data = args is Map ? args : const {};
          return TransitDetailsScreen(
            name: data['name'] as String? ?? 'TransJakarta',
            asset: data['asset'] as String? ?? 'lib/assets/images/tj.png',
          );
        },
        '/departures': (context) => const DeparturesScreen(),
        '/community': (context) => const CommunityScreen(),
        '/destination_detail': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          return DestinationDetailScreen(
            destination: args is Destination ? args : dufanDestination,
          );
        },
        '/notifications': (context) => const NotificationsScreen(),
        '/write_review': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          return WriteReviewScreen(
            destination: args is Destination ? args : dufanDestination,
          );
        },
        '/reviews': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          return ReviewsScreen(
            destination: args is Destination ? args : dufanDestination,
          );
        },
      },
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: const Color(0xFF1E6056),
      foregroundColor: Colors.white,
      title: const Text('Notifikasi'),
    ),
    body: ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) => ListTile(
        leading: index == 4
            ? const Icon(Icons.wb_sunny, color: Colors.amber, size: 38)
            : const CircleAvatar(
                backgroundImage: AssetImage('lib/assets/images/dufan.png'),
              ),
        title: Text(
          index == 4 ? 'Cuaca Sedang Cerah' : 'Dunia Fantasi (DUFAN)',
        ),
        subtitle: Text(
          index == 4
              ? 'Yuk keluar dan jalan-jalan!'
              : '19 Februari 2025 · Transportasi Umum',
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.pushNamed(
          context,
          index == 4 ? '/weather' : '/travel_recap',
        ),
      ),
    ),
  );
}
