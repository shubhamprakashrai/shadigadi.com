import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/providers/service_provider.dart';
import 'screens/add_edit_service_screen.dart';

class MyServicesScreen extends StatefulWidget {
  static const routeName = '/my-services';
  
  final String providerId;
  final String contactNumber;

  const MyServicesScreen({
    Key? key,
    required this.providerId,
    required this.contactNumber,
  }) : super(key: key);

  @override
  State<MyServicesScreen> createState() => _MyServicesScreenState();
}

class _MyServicesScreenState extends State<MyServicesScreen> {
  late final ServiceProvider _serviceProvider;

  @override
  void initState() {
    super.initState();
    _serviceProvider = context.read<ServiceProvider>();
    _loadServices();
  }

  Future<void> _loadServices() async {
    await _serviceProvider.fetchServices(widget.providerId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Services'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddService(context),
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Consumer<ServiceProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.services.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${provider.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadServices,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (provider.services.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.directions_car, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'No services added yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the + button to add your first service',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _loadServices,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.services.length,
              itemBuilder: (context, index) {
                final service = provider.services[index];
                return _ServiceCard(
                  service: service,
                  onEdit: () => _navigateToEditService(context, service),
                  onDelete: () => _confirmDeleteService(context, service.id),
                  onToggleStatus: (isActive) => _toggleServiceStatus(service.id, isActive),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _navigateToAddService(BuildContext context) async {
    final result = await Navigator.pushNamed(
      context,
      AddEditServiceScreen.routeName,
      arguments: {
        'providerId': widget.providerId,
        'contactNumber': widget.contactNumber,
      },
    );

    if (result == true) {
      _loadServices();
    }
  }

  void _navigateToEditService(BuildContext context, ServiceEntity service) async {
    final result = await Navigator.pushNamed(
      context,
      AddEditServiceScreen.routeName,
      arguments: {
        'service': service,
        'providerId': widget.providerId,
        'contactNumber': widget.contactNumber,
      },
    );

    if (result == true) {
      _loadServices();
    }
  }

  Future<void> _confirmDeleteService(BuildContext context, String serviceId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Service'),
        content: const Text('Are you sure you want to delete this service? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('DELETE'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await _serviceProvider.deleteService(serviceId);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Service deleted successfully')),
        );
      }
    }
  }

  Future<void> _toggleServiceStatus(String serviceId, bool isActive) async {
    await _serviceProvider.toggleServiceStatus(serviceId, isActive);
  }
}

class _ServiceCard extends StatelessWidget {
  final ServiceEntity service;
  final VoidCallback onEdit;
  final Function(bool) onToggleStatus;
  final VoidCallback onDelete;

  const _ServiceCard({
    Key? key,
    required this.service,
    required this.onEdit,
    required this.onToggleStatus,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    service.name,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: service.isActive ? Colors.green[50] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: service.isActive ? Colors.green : Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    service.status,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: service.isActive ? Colors.green[800] : Colors.grey[800],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.category, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  service.categoryName,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    service.location,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (service.price != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.attach_money, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    '${service.price!.toStringAsFixed(2)}/day',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.green[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _buildTag(
                    service.isForWedding ? 'Weddi.' : 'Wedd.',
                    service.isForWedding ? Icons.check_circle : Icons.cancel,
                    service.isForWedding ? Colors.green : Colors.grey,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  flex: 1,
                  child: _buildTag(
                    service.isForEvents ? 'Events' : 'Events',
                    service.isForEvents ? Icons.check_circle : Icons.cancel,
                    service.isForEvents ? Colors.green : Colors.grey,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                  onPressed: onEdit,
                  tooltip: 'Edit',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                  onPressed: onDelete,
                  tooltip: 'Delete',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch.adaptive(
                    value: service.isActive,
                    onChanged: onToggleStatus,
                    activeColor: theme.colorScheme.primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, IconData icon, Color? color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      margin: const EdgeInsets.only(right: 2),
      decoration: BoxDecoration(
        color: color?.withOpacity(0.1) ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color ?? Colors.grey),
          const SizedBox(width: 2),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              color: color ?? Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
