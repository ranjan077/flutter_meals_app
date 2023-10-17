import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/data/dummy_data.dart';

class CategoriresScreen extends StatefulWidget {
  const CategoriresScreen({super.key, required this.availableMeals});
  final List<Meal> availableMeals;

  @override
  State<CategoriresScreen> createState() => _CategoriresScreenState();
}

class _CategoriresScreenState extends State<CategoriresScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MealsScreen(
        title: 'Meals screen',
        meals: widget.availableMeals
            .where(
              (meal) => meal.categories.contains(category.id),
            )
            .toList(),
      );
    }));
  }

  @override
  Widget build(context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      builder: (context, child) {
        return SlideTransition(
          position: _animationController.drive(Tween(
            begin: const Offset(0, 0.3),
            end: const Offset(0, 0),
          )),
          child: child,
        );
      },
    );
  }
}
