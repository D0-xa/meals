import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.title,
    required this.onSelectTile,
    required this.icon,
    required this.selected,
  });

  final String title;
  final void Function() onSelectTile;
  final IconData icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
        right: 16,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          size: 26,
        ),
        iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
        title: Text(
          title,
        ),
        titleTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 24,
            ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        selected: selected,
        selectedColor: Theme.of(context).colorScheme.onPrimaryContainer,
        selectedTileColor: Theme.of(context).colorScheme.onPrimary,
        onTap: onSelectTile,
      ),
    );
  }
}
