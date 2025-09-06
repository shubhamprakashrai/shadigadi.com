class ProviderEntity {
  final String id;
  final String name;
  final String serviceType;
  final String location;
  final String phoneNumber;
  final String? imageUrl;
  final double? price;
  final double rating;
  final int totalBookings;

  const ProviderEntity({
    required this.id,
    required this.name,
    required this.serviceType,
    required this.location,
    required this.phoneNumber,
    this.imageUrl,
    this.price,
    this.rating = 0.0,
    this.totalBookings = 0,
  });

  // Copy with method for immutability
  ProviderEntity copyWith({
    String? id,
    String? name,
    String? serviceType,
    String? location,
    String? phoneNumber,
    String? imageUrl,
    double? price,
    double? rating,
    int? totalBookings,
  }) {
    return ProviderEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      serviceType: serviceType ?? this.serviceType,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      totalBookings: totalBookings ?? this.totalBookings,
    );
  }
}
