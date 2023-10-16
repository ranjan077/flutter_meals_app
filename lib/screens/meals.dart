import 'package:flutter/material.dart';
import 'package:meals_app/screens/meal_detail.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key,
      this.title,
      required this.meals,
      required this.onToggleFavorite});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MealDetailScreen(meal: meal, onToggleFavorite: onToggleFavorite);
    }));
  }

  @override
  Widget build(context) {
    final bool noMeals = meals.isEmpty;
    Widget content = noMeals
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
            children: [
              for (Meal meal in meals)
                MealItem(
                  meal: meal,
                  onSelectMeal: _selectMeal,
                )
            ],
          );
    if (title == null) {
      return content;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content);
  }
}
