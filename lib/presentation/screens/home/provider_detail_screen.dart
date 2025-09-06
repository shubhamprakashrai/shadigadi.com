import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shaadigadi/presentation/booking/booking_screen.dart';
import 'package:shaadigadi/presentation/screens/booking/booking_request_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../domain/entities/provider_entity.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../widgets/common_appbar.dart';

class ProviderDetailScreen extends StatelessWidget {
  final ProviderEntity provider;

  const ProviderDetailScreen({
    super.key,
    required this.provider,
  });

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Provider Details',
        showBackButton: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Provider Info Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Provider Name
                          Text(
                            provider.name,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          
                          // Service Type
                          Row(
                            children: [
                              Icon(
                                Icons.directions_car_rounded,
                                color: theme.primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                provider.serviceType,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          
                          // Location
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                color: theme.primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                provider.location,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Contact Section
                  Text(
                    'Contact Provider',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  Row(
                    children: [
                      // Call Button
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _launchUrl('tel:${provider.phoneNumber}'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(Icons.phone_rounded, size: 20),
                          label: const Text('Call'),
                        ),
                      ),
                      
                      const SizedBox(width: 12),
                      
                      // WhatsApp Button
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _launchUrl(
                            'https://wa.me/91${provider.phoneNumber}?text=Hi, I found your profile on ShaadiGadi and would like to know more about your services.',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF25D366), // WhatsApp green
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(Icons.chat_rounded, size: 20),
                          label: const Text('WhatsApp'),
                        ),
                      ),
                    ],
                  ),
                  
                  // Add more details here if needed
                  const SizedBox(height: 80), // Space for the bottom button
                ],
              ),
            ),
          ),
          
          // Fixed bottom button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Haptic feedback
                  HapticFeedback.mediumImpact();
                  
                  Get.to(
                    () => BookingRequestScreen(provider: provider),
                    fullscreenDialog: true,
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 300),
                    routeName: Routes.BOOKING_REQUEST,
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7C4DFF), Color(0xFF6200EA)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_today_rounded, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Request Booking',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

