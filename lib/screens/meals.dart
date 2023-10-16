import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});

  final String title;
  final List<Meal> meals;

  @override
  Widget build(context) {
    final bool noMeals = meals.isEmpty;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: noMeals
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No meals to show.',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Try selecting a different category.',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  )
                ],
              ),
            )
          : ListView(
              children: [for (Meal meal in meals) MealItem(meal: meal)],
            ),
    );
  }
}