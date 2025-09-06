import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          SizedBox(height: 8),
          Text(
            'Frequently Asked Questions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3748),
            ),
          ),
          SizedBox(height: 16),
          FAQItem(
            question: 'How to book a vehicle?',
            answer: '1. Open the provider profile\n2. Tap on "Request Booking"\n3. Fill in the required details\n4. Submit your booking request\n\nYou will receive a confirmation once the provider accepts your request.',
          ),
          FAQItem(
            question: 'Can I contact the provider directly?',
            answer: 'Yes, you can contact the provider directly through the app. Once your booking is confirmed, you will see the provider\'s contact information in the booking details. You can call or message them via WhatsApp for any queries.',
          ),
          FAQItem(
            question: 'Do I need to pay online?',
            answer: 'No, all payments are handled directly with the provider. We do not process any payments through the app to ensure complete transparency between you and the service provider.',
          ),
          FAQItem(
            question: 'How do I cancel a booking?',
            answer: '1. Go to "My Bookings"\n2. Select the booking you want to cancel\n3. Tap on "Cancel Booking"\n4. Provide a reason for cancellation\n\nPlease note that cancellation policies may vary by provider.',
          ),
          FAQItem(
            question: 'What if I need to reschedule my booking?',
            answer: 'To reschedule a booking, please contact the provider directly using the contact information provided in your booking details. We recommend making any schedule changes at least 24 hours in advance.',
          ),
          FAQItem(
            question: 'How do I know if my booking is confirmed?',
            answer: 'You will receive a notification and an email once your booking is confirmed by the provider. You can also check the status of your booking in the "My Bookings" section of the app.',
          ),
          FAQItem(
            question: 'What payment methods are accepted?',
            answer: 'Payment methods vary by provider. Most providers accept cash, UPI, and other digital payment methods. Please confirm the accepted payment methods with your provider when you contact them.',
          ),
          FAQItem(
            question: 'How can I provide feedback about my experience?',
            answer: 'After your booking is completed, you will receive a request to rate your experience. You can also provide feedback directly in the "My Bookings" section by selecting the completed booking and tapping on "Leave Review".',
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: ExpansionTile(
        title: Text(
          widget.question,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2D3748),
          ),
        ),
        trailing: Icon(
          _isExpanded ? Icons.expand_less : Icons.expand_more,
          color: Theme.of(context).primaryColor,
        ),
        onExpansionChanged: (bool expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              widget.answer,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF718096),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
