import 'package:flutter/material.dart';

import 'package:meals/widgets/switches.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/models/meal.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.onToggleFavourite,
    required this.currentFilters,
    required this.availableMeals,
  });

  final void Function(Meal meal) onToggleFavourite;
  final Map<Filter, bool> currentFilters;
  final List<Meal> availableMeals;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;
  }

  void _onToggledGluten(bool isChecked) {
    setState(() {
      _glutenFreeFilterSet = isChecked;
    });
  }

  void _onToggledLactose(bool isChecked) {
    setState(() {
      _lactoseFreeFilterSet = isChecked;
    });
  }

  void _onToggledVegetarian(bool isChecked) {
    setState(() {
      _vegetarianFilterSet = isChecked;
    });
  }

  void _onToggledVegan(bool isChecked) {
    setState(() {
      _veganFilterSet = isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      drawer: MainDrawer(onSelectMenu: (identifier) {
        Navigator.of(context).pop();

        if (identifier == 'Meals') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => MealsScreen(
                title: 'Meals',
                meals: widget.availableMeals,
                onToggleFavourite: widget.onToggleFavourite,
              ),
            ),
          );
        } else if (identifier == 'Cuisine') {
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });
        }
      }),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) {
            return;
          }
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });
        },
        child: Column(
          children: [
            Switches(
              mainLabel: 'Gluten-free',
              subLabel: 'Only include gluten-free meals',
              onOff: _glutenFreeFilterSet,
              onSwitched: _onToggledGluten,
            ),
            Switches(
              mainLabel: 'Lactose-free',
              subLabel: 'Only include lactose-free meals',
              onOff: _lactoseFreeFilterSet,
              onSwitched: _onToggledLactose,
            ),
            Switches(
              mainLabel: 'Vegetarian',
              subLabel: 'Only include vegetarian meals',
              onOff: _vegetarianFilterSet,
              onSwitched: _onToggledVegetarian,
            ),
            Switches(
              mainLabel: 'Vegan',
              subLabel: 'Only include vegan meals',
              onOff: _veganFilterSet,
              onSwitched: _onToggledVegan,
            )
          ],
        ),
      ),
    );
  }
}
