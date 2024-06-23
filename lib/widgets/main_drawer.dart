import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.onSelectMenu,
  });

  final void Function(String identifier) onSelectMenu;

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
          ListTile(
            leading: Icon(
              Icons.restaurant_menu,
              size: 26,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              'Cuisine',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelectMenu('Cuisine');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.restaurant_rounded,
              size: 26,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              'Meals',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelectMenu('Meals');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 26,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelectMenu('Filters');
            },
          ),
        ],
      ),
    );
  }
}
