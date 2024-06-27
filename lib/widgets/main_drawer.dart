import 'package:flutter/material.dart';

import 'package:meals/widgets/drawer_tile.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.onSelectMenu,
    required this.index,
  });

  final void Function(String identifier) onSelectMenu;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood_rounded,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'Cooking Up!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
          DrawerTile(
            title: 'Cuisine',
            onSelectTile: () {
              onSelectMenu('Cuisine');
            },
            icon: Icons.restaurant_menu,
            selected: index == 0 ? true : false,
          ),
          DrawerTile(
            title: 'Meals',
            onSelectTile: () {
              onSelectMenu('Meals');
            },
            icon: Icons.restaurant_rounded,
            selected: false,
          ),
          DrawerTile(
            title: 'Filters',
            onSelectTile: () {
              onSelectMenu('Filters');
            },
            icon: Icons.settings_outlined,
            selected: index == 1 ? true : false,
          ),
        ],
      ),
    );
  }
}
