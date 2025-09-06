import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadigadi/presentation/editprofile/edit_profile_screen.dart';
import 'package:shaadigadi/presentation/changepassword/change_password_screen.dart';
import 'package:shaadigadi/presentation/helpcenter/help_center_screen.dart';
import 'package:shaadigadi/presentation/contactsupport/contact_support_screen.dart';
import 'package:shaadigadi/presentation/termandcontion/terms_conditions_screen.dart';
import 'package:shaadigadi/presentation/privacypolicy/privacy_policy_screen.dart';
import 'package:shaadigadi/presentation/payment/payment_methods_screen.dart';

// Color Scheme
const Color _primaryColor = Color(0xFF6C63FF);
const Color _textColor = Color(0xFF2D3748);
const Color _subtitleColor = Color(0xFF718096);
const Color _cardColor = Color(0xFFF8F9FF);
const Color _borderColor = Color(0xFFE2E8F0);

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  Widget _buildSettingItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    Widget? trailing,
    VoidCallback? onTap,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: _primaryColor, size: 20),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: _textColor,
            ),
          ),
          trailing: trailing ??
              const Icon(
                Icons.chevron_right_rounded,
                color: _subtitleColor,
                size: 24,
              ),
          onTap: onTap,
        ),
        if (showDivider)
          Padding(
            padding: const EdgeInsets.only(left: 70, right: 16),
            child: Divider(height: 1, color: Colors.grey.shade200),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: _textColor,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: _textColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            // Account Settings
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                'Account Settings',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _textColor,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    spreadRadius: 1,
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
                border: Border.all(color: _borderColor, width: 1),
              ),
              child: Column(
                children: [
                  _buildSettingItem(
                    context: context,
                    title: 'Edit Profile',
                    icon: Icons.person_outline_rounded,
                    onTap: () {
                      Get.to(() => const EditProfileScreen());
                      // TODO: Navigate to edit profile
                    },
                  ),
                  _buildSettingItem(
                    context: context,
                    title: 'Change Password',
                    icon: Icons.lock_outline_rounded,
                    onTap: () {
                      Get.to(() => const ChangePasswordScreen());
                    },
                  ),
                  _buildSettingItem(
                    context: context,
                    title: 'Payment Methods',
                    icon: Icons.credit_card_rounded,
                    onTap: () {
                      Get.to(() => const PaymentMethodsScreen());
                    },
                    showDivider: false,
                  ),
                ],
              ),
            ),

            // App Settings
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                'App Settings',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _textColor,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    spreadRadius: 1,
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
                border: Border.all(color: _borderColor, width: 1),
              ),
              child: Column(
                children: [
                  _buildSettingItem(
                    context: context,
                    title: 'Notifications',
                    icon: Icons.notifications_outlined,
                    trailing: Switch.adaptive(
                      value: true,
                      onChanged: (value) {
                        // TODO: Handle notification toggle
                      },
                      activeColor: _primaryColor,
                    ),
                  ),
                  _buildSettingItem(
                    context: context,
                    title: 'Dark Mode',
                    icon: Icons.dark_mode_outlined,
                    trailing: Switch.adaptive(
                      value: false,
                      onChanged: (value) {
                        // TODO: Handle dark mode toggle
                      },
                      activeColor: _primaryColor,
                    ),
                  ),
                  _buildSettingItem(
                    context: context,
                    title: 'Language',
                    icon: Icons.language_rounded,
                    trailing: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'English',
                          style: TextStyle(
                            color: _subtitleColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: _subtitleColor,
                          size: 20,
                        ),
                      ],
                    ),
                    onTap: () {
                      // TODO: Show language selection
                    },
                    showDivider: false,
                  ),
                ],
              ),
            ),

            // Support
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                'Support',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _textColor,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    spreadRadius: 1,
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
                border: Border.all(color: _borderColor, width: 1),
              ),
              child: Column(
                children: [
                  _buildSettingItem(
                    context: context,
                    title: 'Help Center',
                    icon: Icons.help_outline_rounded,
                    onTap: () {
                      Get.to(() => const HelpCenterScreen());
                    },
                  ),
                  _buildSettingItem(
                    context: context,
                    title: 'Contact Support',
                    icon: Icons.support_agent_rounded,
                    onTap: () {
                      Get.to(() => const ContactSupportScreen());
                    },
                  ),
                  _buildSettingItem(
                    context: context,
                    title: 'Terms & Conditions',
                    icon: Icons.description_outlined,
                    onTap: () {
                      Get.to(() => const TermsAndConditionsScreen());
                    },
                  ),
                  _buildSettingItem(
                    context: context,
                    title: 'Privacy Policy',
                    icon: Icons.privacy_tip_outlined,
                    onTap: () {
                      Get.to(() => const PrivacyPolicyScreen());
                    },
                    showDivider: false,
                  ),
                ],
              ),
            ),

            // App Version
            const SizedBox(height: 24),
            Center(
              child: Text(
                'App Version 1.0.0',
                style: TextStyle(
                  color: _subtitleColor.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
