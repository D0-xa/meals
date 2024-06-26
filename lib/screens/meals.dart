import 'package:flutter/material.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final availableWidth = MediaQuery.of(context).size.width;

    Widget content = ListView.builder(
      itemCount: meals.length,
      itemExtent: 0.563 * availableWidth,
      itemBuilder: (ctx, index) => MealItem(
        meal: meals[index],
        onSelectMeal: () => _selectMeal(context, meals[index]),
      ),
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title == null)
              Icon(
                Icons.star_border_purple500_rounded,
                size: 100,
                color: Theme.of(context).colorScheme.secondary,
              )
            else
              Image.asset(
                'assets/images/empty_flutter.png',
                width: 150,
                color: Theme.of(context).colorScheme.secondary,
              ),
            Text(
              'Uh oh ... nothing here!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            if (title == null)
              Text(
                'Try selecting a favourite meal!',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              )
            else
              Text(
                'Try selecting a different category!',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
          ],
        ),
      );
    } else if (availableWidth >= 1200) {
      content = Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 16 / 9,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          children: [
            for (final meal in meals)
              MealItem(
                meal: meal,
                onSelectMeal: () => _selectMeal(context, meal),
              ),
          ],
        ),
      );
    } else if (availableWidth >= 700) {
      content = Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 16 / 9,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          children: [
            for (final meal in meals)
              MealItem(
                meal: meal,
                onSelectMeal: () => _selectMeal(context, meal),
              ),
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
