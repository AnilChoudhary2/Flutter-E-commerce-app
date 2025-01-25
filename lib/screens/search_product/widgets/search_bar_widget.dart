import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final void Function(String) onTextChange;
  final void Function(String) onSubmitted;
  final TextEditingController controller;

  const SearchBarWidget(
      {super.key,
      required this.onTextChange,
      required this.onSubmitted,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        padding: const EdgeInsets.all(8),
        child: TextField(
            onChanged: onTextChange,
            controller: controller,
            onSubmitted: onSubmitted,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.1),
                filled: true,
                hintText: 'Search Product ...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                contentPadding: EdgeInsets.zero)));
  }
}
