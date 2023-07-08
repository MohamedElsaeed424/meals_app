import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  final void Function(Meal meal) onToggelMealFavoriteStatus;
  final List<Meal> availableMeals;
  const CategoriesScreen(
      {super.key,
      required this.onToggelMealFavoriteStatus,
      required this.availableMeals});

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeales = availableMeals
        .where((mealItem) => mealItem.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
              titleCategory: category.title,
              meals: filteredMeales,
              onToggelMealFavoriteStatus: onToggelMealFavoriteStatus,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 3 / 2,
      ),
      children: [
        for (final category in availableCategories)
          CategorieItemData(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
