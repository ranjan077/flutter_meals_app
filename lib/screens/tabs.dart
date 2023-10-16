import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _StatefulWidget();
  }
}

class _StatefulWidget extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> favoritesMeals = [];
  void showInfoMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 3000),
    ));
  }

  void _toggleMealFavorites(Meal meal) {
    var isExisting = favoritesMeals.contains(meal);
    if (isExisting) {
      showInfoMessage('Meal is no longer a favorite.');
      setState(() {
        favoritesMeals.remove(meal);
      });
    } else {
      showInfoMessage('Meal is marked as favorite.');
      setState(() {
        favoritesMeals.add(meal);
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriresScreen(
      onToggleFavorite: _toggleMealFavorites,
    );
    var activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      activeScreen = MealsScreen(
          meals: favoritesMeals, onToggleFavorite: _toggleMealFavorites);
      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: const MainDrawer(),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
