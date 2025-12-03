import 'package:flutter/material.dart';

class SearchRadarButton extends StatelessWidget {
  const SearchRadarButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _backButton(context);
  }

  Widget _backButton(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 8, right: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.surface,
        ),
        child: const Icon(Icons.search_rounded),
      ),
    );
  }
}
