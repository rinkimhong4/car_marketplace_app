import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_marketplace_app/config/routes/app_routes.dart';
import 'package:car_marketplace_app/config/theme/theme_style.dart';
import 'package:car_marketplace_app/core/data/product_data.dart';
import 'package:car_marketplace_app/modules/view/filter_screen.dart';
import 'package:car_marketplace_app/modules/view/search.dart';
import 'package:car_marketplace_app/widget/product_card_widget.dart';
import 'package:car_marketplace_app/widget/special_offers_banner.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Color _backgroundColor = Colors.white;
  Color _iconColor = Colors.black;
  bool isDark = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final bool isScrolled = _scrollController.offset > 0;
    setState(() {
      _backgroundColor = (isScrolled ? AppTheme.secondarySwatch : Colors.white);
      _iconColor = isScrolled ? Colors.white : Colors.black;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(backgroundColor: Colors.white, body: _buildBody()));
  }

  Widget _buildBody() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        _buildAppBar(),
        _buildBodyContent(),
        const SliverToBoxAdapter(
          child: SpecialOffersBanner(),
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

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      elevation: 10,
      backgroundColor: _backgroundColor,
      leadingWidth: 150,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: CachedNetworkImageProvider(
                'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D',
              ),
            ),
            const SizedBox(width: 8),
            // Make the column flexible to avoid overflow
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good morning",
                    style: AppTextStyle.regular12(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Kimong",
                    style: AppTextStyle.medium16(color: _iconColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            RouteView.wishList.go();
          },
          icon: Image.asset(
            'assets/icons/heart.png',
            width: 24,
            height: 24,
            color: _iconColor,
          ),
        ),
        IconButton(
          onPressed: () {
            RouteView.notification.go();
          },
          icon: Image.asset(
            'assets/icons/notification-bing.png',
            width: 24,
            height: 24,
            color: _iconColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBodyContent() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: TextFormField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search items...',
            prefixIcon: IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {
                final query = _searchController.text.trim();
                if (query.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResultScreen(
                          searchQuery: query, products: products),
                    ),
                  );
                }
              },
            ),
            suffixIcon: Tooltip(
              message: 'Filter options',
              child: IconButton(
                icon: const Icon(Icons.tune_rounded, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FilterScreen(),
                    ),
                  );
                },
              ),
            ),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          onFieldSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              // Navigate to search result screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchResultScreen(
                      searchQuery: value.trim(), products: products),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
