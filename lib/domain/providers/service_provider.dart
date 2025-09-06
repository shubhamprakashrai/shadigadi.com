import 'package:flutter/foundation.dart';
import '../entities/service_entity.dart';

class ServiceProvider extends ChangeNotifier {
  final List<ServiceEntity> _services = [];
  bool _isLoading = false;
  String? _error;

  List<ServiceEntity> get services => List.unmodifiable(_services);
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch services for a provider
  Future<void> fetchServices(String providerId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      _services.clear();
      
      // Dummy data
      _services.addAll([
        ServiceEntity(
          id: '1',
          providerId: providerId,
          name: 'Luxury Car Service',
          category: ServiceCategory.car,
          location: 'New York',
          price: 299.99,
          contactNumber: '+1234567890',
          availableFor: {'wedding', 'events'},
          isActive: true,
        ),
        ServiceEntity(
          id: '2',
          providerId: providerId,
          name: 'Wedding Jeep',
          category: ServiceCategory.jeep,
          location: 'Los Angeles',
          price: 199.99,
          contactNumber: '+1234567890',
          availableFor: {'wedding'},
          isActive: true,
        ),
        ServiceEntity(
          id: '3',
          providerId: providerId,
          name: 'Party Bus Service',
          category: ServiceCategory.bus,
          location: 'Chicago',
          price: 499.99,
          contactNumber: '+1234567890',
          availableFor: {'wedding', 'events'},
          isActive: false,
        ),
      ]);
      
      _isLoading = false;
    } catch (e) {
      _error = 'Failed to load services: $e';
      _isLoading = false;
    }
    
    notifyListeners();
  }

  // Add a new service
  Future<void> addService(ServiceEntity service) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: Implement actual API call to add service
      // final newService = await _serviceRepository.addService(service);
      _services.add(service);
      _isLoading = false;
    } catch (e) {
      _error = 'Failed to add service: $e';
      _isLoading = false;
    }
    
    notifyListeners();
  }

  // Update an existing service
  Future<void> updateService(ServiceEntity updatedService) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: Implement actual API call to update service
      // await _serviceRepository.updateService(updatedService);
      final index = _services.indexWhere((s) => s.id == updatedService.id);
      if (index != -1) {
        _services[index] = updatedService;
      }
      _isLoading = false;
    } catch (e) {
      _error = 'Failed to update service: $e';
      _isLoading = false;
    }
    
    notifyListeners();
  }

  // Delete a service
  Future<bool> deleteService(String serviceId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: Implement actual API call to delete service
      // await _serviceRepository.deleteService(serviceId);
      _services.removeWhere((s) => s.id == serviceId);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to delete service: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Toggle service active status
  Future<void> toggleServiceStatus(String serviceId, bool isActive) async {
    final service = _services.firstWhere((s) => s.id == serviceId);
    final updatedService = service.copyWith(isActive: isActive);
    await updateService(updatedService);
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
