import 'package:car_marketplace_app/config/theme/theme_style.dart';
import 'package:car_marketplace_app/core/data/product_data.dart';
import 'package:car_marketplace_app/widget/product_card_widget.dart';
import 'package:flutter/material.dart';

class TopDealsScreen extends StatelessWidget {
  const TopDealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: const _BuildBody(),
    );
  }

  /// --- AppBar Block ---
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Top Deals',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      centerTitle: false,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
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

class _BuildBody extends StatefulWidget {
  const _BuildBody();

  @override
  State<_BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<_BuildBody> {
  int selectedIndex = 0;

  final List<String> names = [
    "Mercedes",
    "Tesla",
    "BMW",
    "Toyota",
    "Volvo",
    "Bugatti",
    "Honda",
    "More",
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Deals',
                  style: AppTextStyle.medium18(color: Colors.black),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: AppTextStyle.regular14(
                      color: AppTheme.secondarySwatch,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: List.generate(
                  names.length + 1,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 10),
                        decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? Colors.black
                              : Colors.transparent,
                          border: Border.all(
                            width: 1,
                            color: selectedIndex == index
                                ? Colors.black
                                : Colors.black.withValues(alpha: 0.6),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          index == 0 ? 'All' : names[index - 1],
                          style: AppTextStyle.medium16(
                            color: selectedIndex == index
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        _buildProductCardList(),
      ],
    );
  }

  Widget _buildProductCardList() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final product = products[index];
            return ProductCard(product: product);
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
