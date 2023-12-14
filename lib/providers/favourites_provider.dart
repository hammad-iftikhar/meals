import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoutieMealsNotifier extends StateNotifier<List<Meal>> {
  FavoutieMealsNotifier() : super([]);

  bool toggleFavouriteMeal(Meal meal) {
    final bool isFavouriteMeal = state.contains(meal);

    if (isFavouriteMeal) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavoutieMealsNotifier, List<Meal>>(
        (ref) => FavoutieMealsNotifier());
