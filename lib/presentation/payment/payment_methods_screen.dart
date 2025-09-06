import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Saved Payment Methods Section
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Saved Payment Methods',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3748),
                ),
              ),
            ),
            
            // Payment Methods List
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  _buildPaymentMethodTile(
                    context,
                    cardType: 'Visa',
                    lastFour: '1234',
                    expiry: '12/25',
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildPaymentMethodTile(
                    context,
                    cardType: 'MasterCard',
                    lastFour: '9876',
                    expiry: '06/26',
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildPaymentMethodTile(
                    context,
                    cardType: 'Visa',
                    lastFour: '4321',
                    expiry: '03/25',
                    isDefault: true,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Add New Payment Method Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Navigate to add payment method screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF).withOpacity(0.1),
                  foregroundColor: const Color(0xFF6C63FF),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(
                      color: const Color(0xFF6C63FF).withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                ),
                icon: const Icon(Icons.add_circle_outline_rounded, size: 22),
                label: const Text(
                  'Add New Payment Method',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Info Text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Your payment information is encrypted and secure. We do not store your full card details.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPaymentMethodTile(
    BuildContext context, {
    required String cardType,
    required String lastFour,
    required String expiry,
    bool isDefault = false,
  }) {
    IconData icon;
    Color color;
    
    // Set icon and color based on card type
    switch (cardType.toLowerCase()) {
      case 'visa':
        icon = Icons.credit_card_rounded;
        color = const Color(0xFF1A1F71); // Visa blue
        break;
      case 'mastercard':
        icon = Icons.credit_card_rounded;
        color = const Color(0xFFEB001B); // Mastercard red
        break;
      default:
        icon = Icons.credit_card_rounded;
        color = const Color(0xFF6C63FF); // Default purple
    }
    
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
      title: Text(
        '$cardType •••• $lastFour',
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        'Expires $expiry${isDefault ? ' • Default' : ''}',
        style: const TextStyle(fontSize: 13),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isDefault)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'DEFAULT',
                style: TextStyle(
                  color: Color(0xFF6C63FF),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, size: 22),
            color: Colors.grey[600],
            onPressed: () {
              _showDeleteConfirmation(context, '$cardType •••• $lastFour');
            },
          ),
        ],
      ),
      onTap: () {
        // TODO: Handle payment method selection/edit
      },
    );
  }
  
  void _showDeleteConfirmation(BuildContext context, String cardInfo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Payment Method'),
        content: Text('Are you sure you want to remove $cardInfo?'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Handle payment method deletion
              Get.snackbar(
                'Success',
                'Payment method removed',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                duration: const Duration(seconds: 2),
              );
            },
            child: const Text(
              'REMOVE',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
