class Routes {
  static Future<String> get initialRoute async {
    return SPLASH;
  }

  // Auth Routes
  static const SPLASH = '/';
  static const ONBOARDING = '/onboarding';
  static const LOGIN = '/login';
  static const OTP_VERIFICATION = '/otp-verification';
  
  // Main App Routes
  static const HOME = '/home';
  static const PROVIDER_DETAIL = '/provider-detail';
  static const BOOKING_REQUEST = '/booking-request';
  
  // Service Management Routes
  static const MY_SERVICES = '/my-services';
  static const ADD_EDIT_SERVICE = '/add-edit-service';
}
