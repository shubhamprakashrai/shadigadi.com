import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../domain/entities/service_entity.dart';
import '../../../../domain/providers/service_provider.dart';

class AddEditServiceScreen extends StatefulWidget {
  static const routeName = '/add-edit-service';

  const AddEditServiceScreen({Key? key}) : super(key: key);

  @override
  State<AddEditServiceScreen> createState() => _AddEditServiceScreenState();
}

class _AddEditServiceScreenState extends State<AddEditServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  late final ServiceProvider _serviceProvider;
  
  // Form controllers
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceController = TextEditingController();
  
  // Form state
  ServiceCategory _selectedCategory = ServiceCategory.jeep;
  bool _isForWedding = true;
  bool _isForEvents = false;
  bool _isLoading = false;
  bool _isEditMode = false;
  String? _serviceId;
  String? _providerId;
  String? _contactNumber;

  @override
  void initState() {
    super.initState();
    _serviceProvider = context.read<ServiceProvider>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize form data if in edit mode
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      _isEditMode = args['service'] != null;
      _providerId = args['providerId'];
      _contactNumber = args['contactNumber'];
      
      if (_isEditMode) {
        final service = args['service'] as ServiceEntity;
        _serviceId = service.id;
        _nameController.text = service.name;
        _locationController.text = service.location;
        _priceController.text = service.price?.toStringAsFixed(2) ?? '';
        _selectedCategory = service.category;
        _isForWedding = service.isForWedding;
        _isForEvents = service.isForEvents;
      } else {
        _providerId = args['providerId'];
        _contactNumber = args['contactNumber'];
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Service' : 'Add New Service'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Service Name
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Service Name',
                        prefixIcon: Icon(Icons.directions_car),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a service name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Category Dropdown
                    DropdownButtonFormField<ServiceCategory>(
                      value: _selectedCategory,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        prefixIcon: Icon(Icons.category),
                        border: OutlineInputBorder(),
                      ),
                      items: ServiceCategory.values.map((category) {
                        final name = category.toString().split('.').last;
                        return DropdownMenuItem<ServiceCategory>(
                          value: category,
                          child: Text(
                            name[0].toUpperCase() + name.substring(1),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Location
                    TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        labelText: 'Location (Village/City)',
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a location';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Price (Optional)
                    TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(
                        labelText: 'Price per day (Optional)',
                        prefixIcon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),

                    // Available For
                    const Text(
                      'Available For',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      title: const Text('Wedding'),
                      value: _isForWedding,
                      onChanged: (value) {
                        setState(() {
                          _isForWedding = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      title: const Text('Events'),
                      value: _isForEvents,
                      onChanged: (value) {
                        setState(() {
                          _isForEvents = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 8),

                    // Contact Number (Read-only)
                    TextFormField(
                      initialValue: _contactNumber,
                      decoration:  InputDecoration(
                        labelText: 'Contact Number',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      readOnly: true,
                      enabled: false,
                    ),
                    const SizedBox(height: 24),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _saveService,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                _isEditMode ? 'UPDATE SERVICE' : 'ADD SERVICE',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _saveService() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final availableFor = <String>[];
      if (_isForWedding) availableFor.add('wedding');
      if (_isForEvents) availableFor.add('events');

      final service = ServiceEntity(
        id: _serviceId ?? DateTime.now().millisecondsSinceEpoch.toString(),
        providerId: _providerId!,
        name: _nameController.text.trim(),
        category: _selectedCategory,
        location: _locationController.text.trim(),
        price: _priceController.text.isNotEmpty
            ? double.tryParse(_priceController.text)
            : null,
        availableFor: availableFor.toSet(),
        contactNumber: _contactNumber!,
      );

      if (_isEditMode) {
        await _serviceProvider.updateService(service);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Service updated successfully')),
          );
        }
      } else {
        await _serviceProvider.addService(service);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Service added successfully')),
          );
        }
      }

      if (mounted) {
        Navigator.of(context).pop(true); // Return success
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
