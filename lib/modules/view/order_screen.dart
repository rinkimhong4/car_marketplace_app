import 'package:car_marketplace_app/config/theme/theme_style.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: const _BuildBody(),
    );
  }

  /// --- AppBar Block ---
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        'My Orders',
        style: AppTextStyle.bold18(color: Colors.black),
      ),
      centerTitle: false,
      leading: const Icon(
        Icons.car_crash,
        color: Colors.black,
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 18.0),
          child: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}

/// --- Body Block ---
class _BuildBody extends StatelessWidget {
  const _BuildBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: SimpleLineTabbar(
        tabs: const ['Active', 'Completed'],
        tabContents: const [
          // --- Active Orders ---
          Column(
            children: [
              Text(
                'Active Orders',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Active Orders',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Active Orders',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Active Orders',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          // --- Completed Orders ---
          Column(
            children: [
              Text(
                'Completed Orders',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Completed Orders',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Completed Orders',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Completed Orders',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ===============

class SimpleLineTabbar extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> tabContents;
  final Color activeColor;
  final Color inactiveColor;
  final double indicatorWeight;
  final bool isScrollable;

  const SimpleLineTabbar({
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
  State<SimpleLineTabbar> createState() => _SimpleLineTabbarState();
}

class _SimpleLineTabbarState extends State<SimpleLineTabbar>
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
