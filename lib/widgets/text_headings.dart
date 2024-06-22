import 'package:flutter/material.dart';

class TextHeadings extends StatelessWidget {
  const TextHeadings(this.heading, {super.key});

  final String heading;

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.solid,
            decorationColor: Theme.of(context).colorScheme.primary,
          ),
    );
  }
}
