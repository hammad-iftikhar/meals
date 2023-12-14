import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/filter.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/meals_provider.dart';

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier() : super(kInitialFilters);

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final selectedFilters = ref.watch(filtersProvider);

  return meals.where((Meal meal) {
    if (selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }

    if (selectedFilters[Filter.lactosFree]! && !meal.isLactoseFree) {
      return false;
    }

    if (selectedFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }

    if (selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }

    return true;
  }).toList();
});
