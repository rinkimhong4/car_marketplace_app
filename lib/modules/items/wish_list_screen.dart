import 'package:car_marketplace_app/core/data/product_data.dart';
import 'package:car_marketplace_app/widget/product_card_widget.dart';
import 'package:flutter/material.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

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
        'My Wishlist',
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

class _BuildBody extends StatelessWidget {
  const _BuildBody();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
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
