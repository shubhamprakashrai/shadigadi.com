enum ServiceCategory { jeep, car, tractor, bus, other }

class ServiceEntity {
  final String id;
  final String providerId;
  final String name;
  final ServiceCategory category;
  final String location;
  final double? price;
  final bool isActive;
  final Set<String> availableFor; // 'wedding', 'events'
  final String contactNumber;
  final DateTime createdAt;
  final DateTime updatedAt;

  ServiceEntity({
    required this.id,
    required this.providerId,
    required this.name,
    required this.category,
    required this.location,
    this.price,
    this.isActive = true,
    Set<String>? availableFor,
    required this.contactNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : availableFor = availableFor ?? {'wedding'},
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  // Convert to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'providerId': providerId,
      'name': name,
      'category': category.toString().split('.').last,
      'location': location,
      if (price != null) 'price': price,
      'isActive': isActive,
      'availableFor': availableFor.toList(),
      'contactNumber': contactNumber,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Create from Firestore
  factory ServiceEntity.fromMap(String id, Map<String, dynamic> map) {
    return ServiceEntity(
      id: id,
      providerId: map['providerId'] ?? '',
      name: map['name'] ?? '',
      category: ServiceCategory.values.firstWhere(
        (e) => e.toString() == 'ServiceCategory.${map['category']}',
        orElse: () => ServiceCategory.other,
      ),
      location: map['location'] ?? '',
      price: map['price']?.toDouble(),
      isActive: map['isActive'] ?? true,
      availableFor: Set<String>.from(map['availableFor'] ?? []),
      contactNumber: map['contactNumber'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  // Create a copy with updated fields
  ServiceEntity copyWith({
    String? id,
    String? providerId,
    String? name,
    ServiceCategory? category,
    String? location,
    double? price,
    bool? isActive,
    Set<String>? availableFor,
    String? contactNumber,
  }) {
    return ServiceEntity(
      id: id ?? this.id,
      providerId: providerId ?? this.providerId,
      name: name ?? this.name,
      category: category ?? this.category,
      location: location ?? this.location,
      price: price ?? this.price,
      isActive: isActive ?? this.isActive,
      availableFor: availableFor ?? this.availableFor,
      contactNumber: contactNumber ?? this.contactNumber,
      createdAt: this.createdAt,
      updatedAt: DateTime.now(),
    );
  }

  String get categoryName {
    return category.toString().split('.').last[0].toUpperCase() +
        category.toString().split('.').last.substring(1);
  }

  String get status => isActive ? 'Active' : 'Inactive';

  bool get isForWedding => availableFor.contains('wedding');
  bool get isForEvents => availableFor.contains('events');
}
