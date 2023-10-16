import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/data/dummy_data.dart';

class CategoriresScreen extends StatelessWidget {
  const CategoriresScreen({super.key});

  void _selectCategory(BuildContext context, Category category) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MealsScreen(
          title: 'Meals screen',
          meals: dummyMeals
              .where(
                (meal) => meal.categories.contains(category.id),
              )
              .toList());
    }));
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick your category')),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                })
        ],
      ),
    );
  }
}