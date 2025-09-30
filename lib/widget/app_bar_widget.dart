import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarBack extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColorLeading;
  final String? title;
  final List<Widget>? actions;

  const AppBarBack({
    super.key,
    this.backgroundColor = Colors.white,
    this.iconColorLeading = Colors.black,
    this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: backgroundColor,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: iconColorLeading,
          size: 22,
        ),
        onPressed: () => Get.back(),
      ),
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            )
          : null,
      centerTitle: false,
      actions: actions,
    );
  }
}
