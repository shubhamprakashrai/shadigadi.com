enum BookingStatus { pending, accepted, rejected }

class BookingRequest {
  final String id;
  final String userId;
  final String userName;
  final String userImage;
  final String phoneNumber;
  final DateTime eventDate;
  final String location;
  final String notes;
  final BookingStatus status;
  final DateTime requestedAt;

  BookingRequest({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.phoneNumber,
    required this.eventDate,
    required this.location,
    this.notes = '',
    this.status = BookingStatus.pending,
    DateTime? requestedAt,
  }) : requestedAt = requestedAt ?? DateTime.now();

  // Convert to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'phoneNumber': phoneNumber,
      'eventDate': eventDate.toIso8601String(),
      'location': location,
      'notes': notes,
      'status': status.toString().split('.').last,
      'requestedAt': requestedAt.toIso8601String(),
    };
  }

  // Create from Firestore
  factory BookingRequest.fromMap(String id, Map<String, dynamic> map) {
    return BookingRequest(
      id: id,
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      userImage: map['userImage'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      eventDate: DateTime.parse(map['eventDate']),
      location: map['location'] ?? '',
      notes: map['notes'] ?? '',
      status: BookingStatus.values.firstWhere(
        (e) => e.toString() == 'BookingStatus.${map['status']}',
        orElse: () => BookingStatus.pending,
      ),
      requestedAt: DateTime.parse(map['requestedAt']),
    );
  }

  // Create a copy with updated fields
  BookingRequest copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userImage,
    DateTime? eventDate,
    String? location,
    String? notes,
    BookingStatus? status,
    DateTime? requestedAt,
  }) {
    return BookingRequest(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      eventDate: eventDate ?? this.eventDate,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      requestedAt: requestedAt ?? this.requestedAt,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
