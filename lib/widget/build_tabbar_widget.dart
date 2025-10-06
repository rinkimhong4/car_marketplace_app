import 'package:car_marketplace_app/config/theme/theme_style.dart';
import 'package:flutter/material.dart';

class TabbarWidget extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> tabContents;
  final Color activeColor;
  final Color inactiveColor;
  final double indicatorWeight;
  final bool isScrollable;

  const TabbarWidget({
    super.key,
    required this.tabs,
    required this.tabContents,
    this.activeColor = Colors.black,
    this.inactiveColor = Colors.grey,
    this.indicatorWeight = 3.0,
    this.isScrollable = false,
  }) : assert(
          tabs.length == tabContents.length,
          'Tabs and contents must have the same length',
        );

  @override
  State<TabbarWidget> createState() => _TabbarWidgetState();
}

class _TabbarWidgetState extends State<TabbarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --- Tab Bar ---
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: widget.isScrollable,
            labelColor: widget.activeColor,
            unselectedLabelColor: widget.inactiveColor,
            indicatorColor: widget.activeColor,
            labelStyle: AppTextStyle.regular14(color: Colors.black),
            indicatorWeight: widget.indicatorWeight,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: widget.tabs.map((tab) => Tab(text: tab)).toList(),
          ),
        ),

        // --- Tab Contents ---
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.tabContents,
          ),
        ),
      ],
    );
  }
}
