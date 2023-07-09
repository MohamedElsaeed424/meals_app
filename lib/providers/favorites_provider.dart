import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);
  bool toggelMealFavoriteStatus(Meal meal) {
    final mealIsFavourite = state.contains(meal);
    if (mealIsFavourite) {
      state = state.where((mealItem) => mealItem.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    // because it dont know which data will yield to
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
