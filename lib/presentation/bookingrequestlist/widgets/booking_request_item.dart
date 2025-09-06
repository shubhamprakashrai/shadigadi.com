import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/booking_request.dart';
import '../../bookingrequestlist/booking_request_detail_screen.dart';

class BookingRequestItem extends StatelessWidget {
  final BookingRequest request;
  final Function(BookingStatus) onStatusUpdated;

  const BookingRequestItem({
    Key? key,
    required this.request,
    required this.onStatusUpdated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPending = request.status == BookingStatus.pending;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingRequestDetailScreen(request: request),
          ),
        );
      },
      child: Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with user info and status
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: request.userImage.isNotEmpty
                      ? NetworkImage(request.userImage)
                      : null,
                  child: request.userImage.isEmpty
                      ? const Icon(Icons.person, size: 20)
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    request.userName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(request.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _getStatusColor(request.status).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    _getStatusText(request.status),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: _getStatusColor(request.status),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Booking details
            _buildDetailRow(
              Icons.calendar_today_rounded,
              'Event Date',
              DateFormat('MMM dd, yyyy - hh:mm a').format(request.eventDate),
              theme,
            ),
            const SizedBox(height: 8),
            _buildDetailRow(
              Icons.location_on_rounded,
              'Location',
              request.location,
              theme,
            ),
            if (request.notes.isNotEmpty) ...[
              const SizedBox(height: 8),
              _buildDetailRow(
                Icons.notes_rounded,
                'Notes',
                request.notes,
                theme,
                maxLines: 2,
              ),
            ],
            
            // Action buttons for pending requests
            if (isPending) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => onStatusUpdated(BookingStatus.accepted),
                      icon: const Icon(Icons.check_circle_outline_rounded, size: 20),
                      label: const Text('Accept'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.green,
                        side: const BorderSide(color: Colors.green),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => onStatusUpdated(BookingStatus.rejected),
                      icon: const Icon(Icons.cancel_outlined, size: 20),
                      label: const Text('Reject'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
      )
    );
  }
  

  Widget _buildDetailRow(IconData icon, String label, String value, ThemeData theme, {int maxLines = 1}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.deepPurple),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.accepted:
        return Colors.green;
      case BookingStatus.rejected:
        return Colors.red;
      case BookingStatus.pending:
      default:
        return Colors.orange;
    }
  }

  String _getStatusText(BookingStatus status) {
    return status.toString().split('.').last.toUpperCase();
  }
}
