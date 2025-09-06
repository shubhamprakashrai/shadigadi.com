import 'package:flutter/material.dart';

enum BookingStatus {
  pending,
  accepted,
  rejected,
}

class BookingEntity {
  final String id;
  final String providerName;
  final String vehicleType;
  final DateTime bookingDate;
  final BookingStatus status;
  final String providerImage;

  const BookingEntity({
    required this.id,
    required this.providerName,
    required this.vehicleType,
    required this.bookingDate,
    required this.status,
    this.providerImage = 'https://via.placeholder.com/40',
  });

  String get statusText {
    switch (status) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.accepted:
        return 'Accepted';
      case BookingStatus.rejected:
        return 'Rejected';
    }
  }

  Color get statusColor {
    switch (status) {
      case BookingStatus.pending:
        return Colors.orange;
      case BookingStatus.accepted:
        return Colors.green;
      case BookingStatus.rejected:
        return Colors.red;
    }
  }

  // Sample data generator
  static List<BookingEntity> get sampleBookings => [
        BookingEntity(
          id: '1',
          providerName: 'John Doe',
          vehicleType: 'Toyota Camry',
          bookingDate: DateTime.now().add(const Duration(days: 2)),
          status: BookingStatus.pending,
        ),
        BookingEntity(
          id: '2',
          providerName: 'Jane Smith',
          vehicleType: 'Honda City',
          bookingDate: DateTime.now().add(const Duration(days: 3)),
          status: BookingStatus.accepted,
        ),
        BookingEntity(
          id: '3',
          providerName: 'Mike Johnson',
          vehicleType: 'Hyundai Creta',
          bookingDate: DateTime.now().add(const Duration(days: -1)),
          status: BookingStatus.rejected,
        ),
      ];
}
