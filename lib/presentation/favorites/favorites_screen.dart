import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/providers/favorites_provider.dart';
import '../screens/base_screen.dart';
import '../widgets/provider_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, _) {
        debugPrint('Favorites list updated. Count: ${favoritesProvider.favorites.length}');
        return Column(
          mainAxisAlignment: favoritesProvider.favorites.isEmpty?MainAxisAlignment.center:MainAxisAlignment.start,
          crossAxisAlignment: favoritesProvider.favorites.isEmpty?CrossAxisAlignment.center:CrossAxisAlignment.start,
          children: [
            favoritesProvider.favorites.isEmpty
              ? Center(child: _buildEmptyState())
              : _buildFavoritesList(favoritesProvider.favorites, favoritesProvider),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No favorites yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'Save your favorite providers for quick access',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList(
    List<ProviderEntity> favorites,
    FavoritesProvider favoritesProvider,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        // Force a rebuild by creating a new list reference
        // This ensures the UI updates with the latest favorites
        await Future.delayed(const Duration(milliseconds: 300));
        return;
      },
      child: Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final provider = favorites[index];
            return Dismissible(
              key: Key(provider.id),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                color: Colors.red,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              confirmDismiss: (direction) async {
                // Show confirmation dialog
                final shouldRemove = await Get.dialog<bool>(
                  AlertDialog(
                    title: const Text('Remove from Favorites'),
                    content: Text('Remove ${provider.name} from your favorites?'),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(result: false),
                        child: const Text('CANCEL'),
                      ),
                      TextButton(
                        onPressed: () => Get.back(result: true),
                        child: const Text('REMOVE'),
                      ),
                    ],
                  ),
                );
                return shouldRemove ?? false;
              },
              onDismissed: (_) {
                // Remove the item from favorites
                favoritesProvider.removeFromFavorites(provider);
                
                // Show undo snackbar
                Get.snackbar(
                  'Removed',
                  '${provider.name} removed from favorites',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 3),
                  mainButton: TextButton(
                    onPressed: () {
                      // Add back to favorites if undo is pressed
                      favoritesProvider.addToFavorites(provider);
                      Get.back(); // Close the snackbar
                    },
                    child: const Text('UNDO'),
                  ),
                );
              },
              child: ProviderCard(
                provider: provider,
                isFavorite: true,
                onFavoriteChanged: (isFavorite) {
                  if (!isFavorite) {
                    favoritesProvider.removeFromFavorites(provider);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
