import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadigadi/presentation/myservice/my_services_screen.dart';
import 'package:shaadigadi/presentation/myservice/screens/add_edit_service_screen.dart';
import '../../config.dart';
import '../../presentation/screens.dart';
import '../../domain/entities/provider_entity.dart';
import '../../presentation/screens/booking/booking_request_screen.dart';
import '../../presentation/screens/home/provider_detail_screen.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;
  EnvironmentsBadge({required this.child});
  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    // Splash Screen
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
    ),
    
    // Onboarding Screen
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnboardingScreen(),
    ),
    
    // Auth Screens
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.OTP_VERIFICATION,
      page: () {
        final phoneNumber = Get.arguments as String? ?? '';
        return OtpVerificationScreen(phoneNumber: phoneNumber);
      },
    ),
    
    // Main App Screens
    GetPage(
      name: Routes.HOME,
      page: () => const MainScreen(),
    ),
    
    // Provider Detail Screen
    GetPage(
      name: Routes.PROVIDER_DETAIL,
      page: () => ProviderDetailScreen(
        provider: Get.arguments as ProviderEntity,
      ),
    ),
    
    // Booking Request Screen
    GetPage(
      name: Routes.BOOKING_REQUEST,
      page: () => BookingRequestScreen(
        provider: Get.arguments as ProviderEntity,
      ),
    ),
    
    // My Services Screen
    GetPage(
      name: Routes.MY_SERVICES,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return MyServicesScreen(
          providerId: args['providerId'],
          contactNumber: args['contactNumber'],
        );
      },
    ),
    
    // Add/Edit Service Screen
    GetPage(
      name: Routes.ADD_EDIT_SERVICE,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return AddEditServiceScreen();
      },
    ),
  ];
}
