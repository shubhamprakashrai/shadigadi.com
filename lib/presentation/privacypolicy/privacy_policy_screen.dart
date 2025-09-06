import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
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
                    content: 'Welcome to ShaadiGadi. We are committed to protecting your personal information and your right to privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application and services.',
                  ),
                  
                  const Divider(height: 40),
                  
                  // Information We Collect Section
                  _buildSection(
                    title: '2. Information We Collect',
                    content: 'We collect personal information that you voluntarily provide to us when you register on the app, express an interest in obtaining information about us or our products and services, or otherwise when you contact us. The personal information we collect may include the following:\n\n• Personal Information: Name, email address, phone number, and other similar contact data.\n• Payment Information: Credit card numbers and billing information (processed securely through our payment processors).\n• Usage Data: Information about how you use our app and services.\n• Device Information: Such as your mobile device ID, model, and operating system.',
                  ),
                  
                  const Divider(height: 40),
                  
                  // How We Use Information Section
                  _buildSection(
                    title: '3. How We Use Information',
                    content: 'We use the information we collect for various purposes, including to:\n\n• Provide, operate, and maintain our services\n• Process and complete transactions\n• Send you related information, including confirmations, invoices, and customer service\n• Send you technical notices, updates, and support messages\n• Respond to your comments, questions, and requests\n• Monitor and analyze usage and trends to improve user experience\n• Detect, investigate, and prevent fraudulent transactions and other illegal activities',
                  ),
                  
                  const Divider(height: 40),
                  
                  // Sharing of Information Section
                  _buildSection(
                    title: '4. Sharing of Information',
                    content: 'We may share your information in the following situations:\n\n• With Service Providers: We may share your data with third-party vendors who perform services on our behalf.\n• Business Transfers: We may share or transfer your information in connection with any merger, sale of company assets, or acquisition.\n• With Your Consent: We may disclose your personal information for any other purpose with your consent.\n• Legal Requirements: If required to do so by law or in response to valid requests by public authorities.',
                  ),
                  
                  const Divider(height: 40),
                  
                  // User Rights Section
                  _buildSection(
                    title: '5. Your Data Protection Rights',
                    content: 'Depending on your location, you may have the following rights regarding your personal data:\n\n• The right to access, update, or delete your information\n• The right to rectification if your information is inaccurate or incomplete\n• The right to object to our processing of your personal data\n• The right to request restriction of processing your personal information\n• The right to data portability\n• The right to withdraw consent\n\nTo exercise any of these rights, please contact us using the information in the "Contact Us" section below.',
                  ),
                  
                  const Divider(height: 40),
                  
                  // Data Security Section
                  _buildSection(
                    title: '6. Data Security',
                    content: 'We implement appropriate technical and organizational measures to protect the security of your personal information. However, please remember that no method of transmission over the Internet or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your personal information, we cannot guarantee its absolute security.',
                  ),
                  
                  const Divider(height: 40),
                  
                  // Changes to This Policy Section
                  _buildSection(
                    title: '7. Changes to This Policy',
                    content: 'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last Updated" date. You are advised to review this Privacy Policy periodically for any changes.',
                  ),
                  
                  const Divider(height: 40),
                  
                  // Contact Us Section
                  _buildSection(
                    title: '8. Contact Us',
                    content: 'If you have any questions or concerns about this Privacy Policy, please contact us at:\n\nEmail: privacy@shaadigadi.com\nPhone: +1 (555) 123-4567\nAddress: 123 Wedding Lane, Suite 100, New Delhi, 110001, India',
                  ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          
          // Close Button
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
                'Close',
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
            color: Color(0xFF6C63FF),
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
