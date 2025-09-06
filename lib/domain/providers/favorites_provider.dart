import 'package:flutter/foundation.dart';
import '../entities/provider_entity.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<ProviderEntity> _favorites = [];

  List<ProviderEntity> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(ProviderEntity provider) {
    return _favorites.any((p) => p.id == provider.id);
  }

  void addToFavorites(ProviderEntity provider) {
    if (!isFavorite(provider)) {
      _favorites.add(provider);
      notifyListeners();
    }
  }

  void removeFromFavorites(ProviderEntity provider) {
    _favorites.removeWhere((p) => p.id == provider.id);
    notifyListeners();
  }

  void toggleFavorite(ProviderEntity provider) {
    if (isFavorite(provider)) {
      removeFromFavorites(provider);
    } else {
      addToFavorites(provider);
    }
  }
}
