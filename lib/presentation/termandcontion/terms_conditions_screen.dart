import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Last Updated: September 5, 2025',
                    style: TextStyle(
                      color: Color(0xFF718096),
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Introduction Section
                  _buildSection(
                    title: '1. Introduction',
                    content: 'Welcome to ShaadiGadi. These Terms of Service ("Terms") govern your access to and use of the ShaadiGadi mobile application and related services (collectively, the "Service"). By accessing or using the Service, you agree to be bound by these Terms.',
                  ),
                  
                  const Divider(height: 40),
                  
                  // User Responsibilities Section
                  _buildSection(
                    title: '2. User Responsibilities',
                    content: 'As a user of the Service, you agree to the following responsibilities:\n\n• Provide accurate and complete information when creating an account\n• Maintain the confidentiality of your account credentials\n• Use the Service only for lawful purposes\n• Not engage in any activity that interferes with or disrupts the Service\n• Not use the Service to transmit any harmful or malicious code',
                  ),
                  
                  const Divider(height: 40),
                  
                  // Booking Rules Section
                  _buildSection(
                    title: '3. Booking Rules',
                    content: 'When using our booking services, you agree to the following rules:\n\n• All bookings are subject to vehicle and provider availability\n• Cancellation policies vary by service provider\n• You must be at least 18 years old to make a booking\n• Any changes to bookings must be made through the app\n• Pricing is subject to change without notice',
                  ),
                  
                  const Divider(height: 40),
                  
                  // Payment Terms Section
                  _buildSection(
                    title: '4. Payment Terms',
                    content: '• All payments are processed securely through our payment partners\n• We accept various payment methods as indicated during checkout\n• Full payment may be required at the time of booking\n• Refunds are subject to the cancellation policy of the service provider\n• Any disputes regarding payments must be reported within 7 days',
                  ),
                  
                  const Divider(height: 40),
                  
                  // Limitations of Liability Section
                  _buildSection(
                    title: '5. Limitations of Liability',
                    content: 'To the maximum extent permitted by law, ShaadiGadi shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses, resulting from:\n\n• Your access to or use of or inability to access or use the Service\n• Any conduct or content of any third party on the Service\n• Any content obtained from the Service\n• Unauthorized access, use, or alteration of your transmissions or content',
                  ),
                  
                  const Divider(height: 40),
                  
                  // Governing Law Section
                  _buildSection(
                    title: '6. Governing Law',
                    content: 'These Terms shall be governed by and construed in accordance with the laws of [Your Country/State], without regard to its conflict of law provisions.',
                  ),
                  
                  const Divider(height: 40),
                  
                  // Changes to Terms Section
                  _buildSection(
                    title: '7. Changes to Terms',
                    content: 'We reserve the right to modify or replace these Terms at any time at our sole discretion. We will provide notice of any changes by posting the new Terms on this page and updating the "Last Updated" date at the top of these Terms.',
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          
          // Agree Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'I Agree',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            height: 1.6,
            color: Color(0xFF718096),
          ),
        ),
      ],
    );
  }
}
