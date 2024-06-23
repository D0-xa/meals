import 'package:flutter/material.dart';

import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/data/dummy_data.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;
  var _selectedMeals = dummyMeals;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(5),
        showCloseIcon: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  void _toggleMealFavouriteStatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favourite.');
    } else {
      setState(() {
        _favouriteMeals.add(meal);
      });
      _showInfoMessage('Marked as favourite!');
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'Filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            onToggleFavourite: _toggleMealFavouriteStatus,
            currentFilters: _selectedFilters,
            availableMeals: _selectedMeals,
          ),
        ),
      );

      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    } else if (identifier == 'Meals') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => MealsScreen(
            title: 'Meals',
            meals: _selectedMeals,
            onToggleFavourite: _toggleMealFavouriteStatus,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    _selectedMeals = availableMeals;

    Widget activePage = CategoriesScreen(
      onToggleFavourite: _toggleMealFavouriteStatus,
      availableMeals: availableMeals,
    );
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favouriteMeals,
        onToggleFavourite: _toggleMealFavouriteStatus,
      );
      activePageTitle = 'Your Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectMenu: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        elevation: 3,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal_rounded),
            label: 'Categories',
            activeIcon: Icon(Icons.set_meal_outlined),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border_rounded),
            label: 'Favourites',
            activeIcon: Icon(Icons.star_rate_rounded),
          ),
        ],
      ),
    );
  }
}
