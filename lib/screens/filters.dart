import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/widgets/switches.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      drawer: MainDrawer(
        onSelectMenu: (identifier) {
          Navigator.of(context).pop();

          if (identifier == 'Meals') {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => MealsScreen(
                  title: 'Meals',
                  meals: ref.watch(filteredMealsProvider),
                ),
              ),
            );
          } else if (identifier == 'Cuisine') {
            Navigator.of(context).pop(0);
          }
        },
        index: index,
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) {
            return;
          }
          Navigator.of(context).pop(0);
        },
        child: Column(
          children: [
            Switches(
              mainLabel: 'Gluten-free',
              subLabel: 'Only include gluten-free meals',
              onOrOff: currentFilters[Filter.glutenFree]!,
              onSwitched: (bool isChecked) => ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked),
            ),
            Switches(
              mainLabel: 'Lactose-free',
              subLabel: 'Only include lactose-free meals',
              onOrOff: currentFilters[Filter.lactoseFree]!,
              onSwitched: (bool isChecked) => ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked),
            ),
            Switches(
              mainLabel: 'Vegetarian',
              subLabel: 'Only include vegetarian meals',
              onOrOff: currentFilters[Filter.vegetarian]!,
              onSwitched: (bool isChecked) => ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked),
            ),
            Switches(
              mainLabel: 'Vegan',
              subLabel: 'Only include vegan meals',
              onOrOff: currentFilters[Filter.vegan]!,
              onSwitched: (bool isChecked) => ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked),
            )
          ],
        ),
      ),
    );
  }
}
