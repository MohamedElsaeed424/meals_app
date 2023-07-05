import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealsScreen extends StatelessWidget {
  final String titleCategory;
  final List<Meal> meals;
  const MealsScreen(
      {super.key, required this.titleCategory, required this.meals});
  @override
  Widget build(BuildContext context) {
    Widget body = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Uh oh ... nothing here!",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.background),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Try selecting diffrent category.",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.background),
          )
        ],
      ),
    );
    if (meals.isNotEmpty) {
      ListView.builder(
          itemCount: meals.length,
          itemBuilder: ((context, index) => Text(
                meals[index].title,
              )));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(titleCategory),
      ),
      body: body,
    );
  }
}
