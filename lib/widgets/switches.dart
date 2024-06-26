import 'package:flutter/material.dart';

class Switches extends StatelessWidget {
  const Switches({
    super.key,
    required this.mainLabel,
    required this.subLabel,
    required this.onOrOff,
    required this.onSwitched,
  });

  final String mainLabel;
  final String subLabel;
  final bool onOrOff;
  final void Function(bool newValue) onSwitched;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      value: onOrOff,
      onChanged: onSwitched,
      title: Text(
        mainLabel,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      subtitle: Text(
        subLabel,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      // activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(
        left: 36,
        right: 24,
      ),
    );
  }
}
