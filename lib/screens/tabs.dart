import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/favourites.provider.dart';
import 'package:meals/providers/filters_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  // with SingleTickerProviderStateMixin {
  int _selectedPageIndex = 0;
  int _selectedTile = 0;
  // late AnimationController _animationController;    explicit animation

  // @override
  // void initState() {
  //   super.initState();

  //   _animationController = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 500),
  //     lowerBound: 0,
  //     upperBound: 1,
  //   );

  //   _animationController.forward();
  // }

  // @override
  // void dispose() {
  //   _animationController.dispose();
  //   super.dispose();
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'Filters') {
      _selectedTile = 1;
      final value = await Navigator.of(context).push<int>(
        _createRoute(
          FiltersScreen(
            index: _selectedTile,
          ),
        ),
      );

      setState(() {
        _selectedTile = value ?? 1;
      });
    } else if (identifier == 'Meals') {
      Navigator.of(context).push(
        _createRoute(
          MealsScreen(
            title: 'Meals',
            meals: ref.watch(filteredMealsProvider),
          ),
        ),
      );
    }
  }

  Route<int> _createRoute(Widget screen) {
    return PageRouteBuilder(
      transitionDuration: Durations.extralong2,
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
        position: animation.drive(
          Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).chain(
            CurveTween(curve: Curves.easeInOut),
          ),
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      activePage = MealsScreen(
        meals: favouriteMeals,
      );
      activePageTitle = 'Your Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectMenu: _setScreen,
        index: _selectedTile,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        elevation: 3,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.set_meal_outlined),
            label: 'Categories',
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 26,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.set_meal_rounded),
            ),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.star_border_rounded),
            label: 'Favourites',
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 22,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.star_rate_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
