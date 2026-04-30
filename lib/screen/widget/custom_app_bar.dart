import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onPressed;

  const CustomAppBar({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1A1E2C)),
        onPressed: onPressed ?? () => Navigator.of(context).pop(),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF1A1E2C),
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}