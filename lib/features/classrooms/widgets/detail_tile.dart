import 'package:flutter/material.dart';

class DetailTile extends StatelessWidget {
  final String title;
  final String value;
  const DetailTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Text(value, style: Theme.of(context).textTheme.labelMedium)
      ],
    );
  }
}
