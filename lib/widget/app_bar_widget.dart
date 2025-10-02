import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarBack extends StatefulWidget {
  final Color backgroundColor;
  final Color iconColorLeading;
  final String? title;
  final List<Widget>? actions;
  final ScrollController? scrollController;

  const AppBarBack({
    super.key,
    this.backgroundColor = Colors.white,
    this.iconColorLeading = Colors.black,
    this.title,
    this.actions,
    this.scrollController,
  });

  @override
  State<AppBarBack> createState() => _AppBarBackState();
}

class _AppBarBackState extends State<AppBarBack> {
  late Color currentBackgroundColor;
  late Color currentIconColor;

  @override
  void initState() {
    super.initState();
    currentBackgroundColor = widget.backgroundColor;
    currentIconColor = widget.iconColorLeading;
    widget.scrollController?.addListener(_onScroll);
  }

  void _onScroll() {
    if (widget.scrollController == null) return;
    final bool isScrolled = widget.scrollController!.offset > 0;
    final Color newBgColor = isScrolled ? Colors.red : widget.backgroundColor;
    final Color newIconColor =
        isScrolled ? Colors.white : widget.iconColorLeading;
    if (currentBackgroundColor != newBgColor ||
        currentIconColor != newIconColor) {
      setState(() {
        currentBackgroundColor = newBgColor;
        currentIconColor = newIconColor;
      });
    }
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: currentBackgroundColor,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: currentIconColor,
          size: 22,
        ),
        onPressed: () => Get.back(),
      ),
      title: widget.title != null
          ? Text(
              widget.title!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: currentIconColor,
              ),
            )
          : null,
      centerTitle: false,
      actions: widget.actions,
    );
  }
}
