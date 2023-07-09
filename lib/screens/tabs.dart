import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/meals_providers.dart';

import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

import '../providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  // final List<Meal> _favouritMeals = [];

  // Moved to meal details
  // void _showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).removeCurrentSnackBar();
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text(message)));
  // }

  //      Managing this in favourites_provider.dart class

  // void _toggelMealFavoriteStatus(Meal meal) {
  //   final isMealExist = _favouritMeals.contains(meal);
  //   if (isMealExist) {
  //     setState(() {
  //       _favouritMeals.remove(meal);
  //       _showInfoMessage("Meal is no longer a favorite");
  //     });
  //   } else {
  //     setState(() {
  //       _favouritMeals.add(meal);
  //       _showInfoMessage("Marked as a favorite");
  //     });
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String screen) async {
    // to pop the drawer first
    Navigator.of(context).pop();
    if (screen == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
          builder: (ctx) => const FilterScreen(
              // currentFilters: _selectedFilters,
              )));
      // if no filter seted use default one
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealProvider);
    final activeFilters = ref.watch(filtersProvider);
    final availableMeals = meals.where((meal) {
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    print(availableMeals.length);

    Widget activePage = CategoriesScreen(
      // onToggelMealFavoriteStatus: _toggelMealFavoriteStatus,
      availableMeals: availableMeals,
    );

    var activePageTitle = "Categories";
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        // onToggelMealFavoriteStatus: _toggelMealFavoriteStatus,
        meals: favoriteMeals,
      );
      activePageTitle = "Your Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
          ]),
    );
  }
}
