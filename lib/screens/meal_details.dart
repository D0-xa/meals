import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/providers/favourites.provider.dart';
import 'package:meals/widgets/text_headings.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeals = ref.watch(favouriteMealsProvider);

    final isFavourite = favouriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final infoMessage = ref
                  .read(favouriteMealsProvider.notifier)
                  .toggleMealFavouriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(infoMessage),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(16),
                  showCloseIcon: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              );
            },
            icon: Icon(
                isFavourite ? Icons.star_outlined : Icons.star_border_outlined),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;

          return SingleChildScrollView(
            child: Column(
              children: [
                if (availableWidth >= 1200)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Image.network(
                            meal.imageUrl,
                            width: 0.45 * availableWidth,
                            height: 0.253 * availableWidth,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              const TextHeadings('Ingredients'),
                              const SizedBox(
                                height: 10,
                              ),
                              for (final ingredient in meal.ingredients)
                                Text(
                                  ingredient,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                ),
                              const SizedBox(
                                height: 20,
                              ),
                              const TextHeadings('Steps'),
                              const SizedBox(
                                height: 10,
                              ),
                              for (final step in meal.steps)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  child: Text(
                                    step,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                else if (availableWidth >= 800)
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 16),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        meal.imageUrl,
                        width: 0.65 * availableWidth,
                        height: 0.366 * availableWidth,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  Image.network(
                    meal.imageUrl,
                    width: double.infinity,
                    height: 0.563 * availableWidth,
                    fit: BoxFit.cover,
                  ),
                if (availableWidth < 1200)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 14,
                      ),
                      const TextHeadings('Ingredients'),
                      const SizedBox(
                        height: 10,
                      ),
                      for (final ingredient in meal.ingredients)
                        Text(
                          ingredient,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextHeadings('Steps'),
                      const SizedBox(
                        height: 10,
                      ),
                      for (final step in meal.steps)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: Text(
                            step,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
