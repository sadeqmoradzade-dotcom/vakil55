import 'package:flutter/material.dart';

/// Rounded search input field used on the home screen.
class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.controller,
    this.onSubmitted,
  });

  /// Controls the text being edited by the search field.
  final TextEditingController controller;

  /// Invoked when the user submits the field from the keyboard.
  final VoidCallback? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      onSubmitted: (_) => onSubmitted?.call(),
      decoration: const InputDecoration(
        hintText: 'مثلاً مهندس',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
