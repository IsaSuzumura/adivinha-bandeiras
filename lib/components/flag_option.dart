import 'package:flutter/material.dart';

class FlagOption extends StatelessWidget {
  final String optionText;
  final VoidCallback onTap;

  const FlagOption({
    super.key,
    required this.optionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(optionText),
        onTap: onTap,
      ),
    );
  }
}
