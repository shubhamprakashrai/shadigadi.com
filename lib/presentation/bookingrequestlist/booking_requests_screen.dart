import 'package:flutter/material.dart';
import 'package:shaadigadi/presentation/bookingrequestlist/widgets/booking_request_item.dart';
import '../../domain/entities/booking_request.dart';
import 'package:shimmer/shimmer.dart';

class BookingRequestsListScreen extends StatefulWidget {
  const BookingRequestsListScreen({Key? key}) : super(key: key);

  @override
  _BookingRequestsListScreenState createState() =>
      _BookingRequestsListScreenState();
}

class _BookingRequestsListScreenState extends State<BookingRequestsListScreen> {
  // TODO: Replace with actual data from provider/repository
  List<BookingRequest> _bookingRequests = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBookingRequests();
  }

  Future<void> _loadBookingRequests() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // TODO: Replace with actual data fetching
    setState(() {
      _bookingRequests = _getMockBookingRequests();
      _isLoading = false;
    });
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isLoading = true;
    });
    await _loadBookingRequests();
  }

  Future<void> _updateBookingStatus(
      String requestId, BookingStatus newStatus) async {
    // TODO: Implement actual status update logic with backend
    setState(() {
      _bookingRequests = _bookingRequests.map((request) {
        if (request.id == requestId) {
          return request.copyWith(status: newStatus);
        }
        return request;
      }).toList();
    });

    // Show success message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            newStatus == BookingStatus.accepted
                ? 'Booking accepted successfully!'
                : 'Booking rejected.',
          ),
          backgroundColor:
              newStatus == BookingStatus.accepted ? Colors.green : Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Requests'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? _buildLoadingShimmer()
          : _bookingRequests.isEmpty
              ? _buildEmptyState()
              : _buildBookingList(),
    );
  }

  Widget _buildBookingList() {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        itemCount: _bookingRequests.length,
        itemBuilder: (context, index) {
          final request = _bookingRequests[index];
          return BookingRequestItem(
            request: request,
            onStatusUpdated: (newStatus) {
              _updateBookingStatus(request.id, newStatus);
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty_booking.png', // Add this asset to your project
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 24),
          Text(
            'No Booking Requests Yet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
          ),
          const SizedBox(height: 12),
          Text(
            'When you receive booking requests, they\'ll appear here.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _handleRefresh,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Refresh'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5, // Number of shimmer placeholders
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                          radius: 20, backgroundColor: Colors.white),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              height: 16,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 4),
                            Container(
                              width: 80,
                              height: 12,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildShimmerRow(),
                  const SizedBox(height: 8),
                  _buildShimmerRow(),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildShimmerRow() {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: Colors.white,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 12,
                color: Colors.white,
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                height: 14,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Mock data - Replace with actual data fetching
  List<BookingRequest> _getMockBookingRequests() {
    final now = DateTime.now();
    return [
      BookingRequest(
        id: '1',
        userId: 'user1',
        userName: 'John Doe',
        userImage: '',
        eventDate: now.add(const Duration(days: 7)),
        location: 'Grand Ballroom, New York',
        notes: 'Please arrive 1 hour before the event',
        status: BookingStatus.pending, phoneNumber: '',
      ),
      BookingRequest(
        id: '2',
        userId: 'user2',
        userName: 'Jane Smith',
        userImage: '',
        eventDate: now.add(const Duration(days: 14)),
        location: 'Beach Resort, Miami',
        notes: 'Outdoor event, please bring your equipment',
        status: BookingStatus.pending, phoneNumber: '',
      ),
      BookingRequest(
        id: '3',
        userId: 'user3',
        userName: 'Michael Johnson',
        userImage: '',
        eventDate: now.add(const Duration(days: 21)),
        location: 'Downtown Convention Center',
        status: BookingStatus.accepted, phoneNumber: '',
      ),
    ];
  }
}
