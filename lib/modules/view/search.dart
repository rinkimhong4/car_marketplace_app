import 'dart:async';
import 'dart:math';

import 'package:car_marketplace_app/core/models/car_model.dart';
import 'package:car_marketplace_app/core/models/product_detail_model.dart';
import 'package:car_marketplace_app/modules/view/filter_screen.dart';
import 'package:car_marketplace_app/widget/product_card_widget.dart';
import 'package:flutter/material.dart';

class SearchResultScreen extends StatefulWidget {
  final String searchQuery;
  final List<ProductDetail> products;

  const SearchResultScreen({
    super.key,
    required this.searchQuery,
    required this.products,
  });

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late final TextEditingController _searchController;
  late String currentQuery;
  Timer? _debounce;
  FilterData? _filterData;

  @override
  void initState() {
    super.initState();
    currentQuery = widget.searchQuery;
    _searchController = TextEditingController(text: currentQuery);
    _filterData = null;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        currentQuery = _searchController.text.trim();
      });
    });
  }

  Widget _buildBodyContent() {
    return Padding(
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
                setState(() {
                  currentQuery = query;
                });
              }
            },
          ),
          suffix: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Tooltip(
                message: 'Filter options',
                child: IconButton(
                  icon: const Icon(Icons.tune_rounded, color: Colors.black),
                  onPressed: () async {
                    final result = await Navigator.push<FilterData>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FilterScreen(),
                      ),
                    );
                    if (result != null) {
                      setState(() {
                        _filterData = result;
                      });
                    }
                  },
                ),
              ),
              if (_filterData != null) ...[
                const SizedBox(width: 8),
                Tooltip(
                  message: 'Clear filters',
                  child: IconButton(
                    icon: const Icon(Icons.clear, color: Colors.black),
                    onPressed: () {
                      setState(() {
                        _filterData = null;
                      });
                    },
                  ),
                ),
              ],
            ],
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
          final query = value.trim();
          if (query.isNotEmpty) {
            setState(() {
              currentQuery = query;
            });
          }
        },
      ),
    );
  }

  List<ProductDetail> _getFilteredProducts() {
    List<ProductDetail> filtered = widget.products;
    if (currentQuery.isNotEmpty) {
      filtered = filtered
          .where((product) =>
              product.title.toLowerCase().contains(currentQuery.toLowerCase()))
          .toList();
    }
    if (_filterData != null) {
      final fd = _filterData!;
      if (fd.selectedBrands.isNotEmpty) {
        filtered = filtered
            .where((product) => fd.selectedBrands.contains(product.brand))
            .toList();
      }
      if (fd.selectedConditions.isNotEmpty) {
        filtered = filtered
            .where(
                (product) => fd.selectedConditions.contains(product.condition))
            .toList();
      }
      if (fd.selectedRatings.isNotEmpty) {
        final minRating =
            fd.selectedRatings.map(int.parse).reduce((a, b) => min(a, b));
        filtered = filtered
            .where((product) => product.rating >= minRating.toDouble())
            .toList();
      }
      filtered = filtered
          .where((product) =>
              product.price >= fd.priceRange.start &&
              product.price <= fd.priceRange.end)
          .toList();
      // sort
      switch (fd.selectedSort) {
        case 'Popular':
          filtered.sort((a, b) => b.rating.compareTo(a.rating));
          break;
        case 'Price High':
          filtered.sort((a, b) => b.price.compareTo(a.price));
          break;
        case 'Most Recent':
          filtered.sort((a, b) => a.price.compareTo(b.price));
          break;
      }
    }
    return filtered;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _getFilteredProducts();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Results for "$currentQuery"'),
        ),
        body: Column(
          children: [
            _buildBodyContent(),
            Expanded(
              child: filteredProducts.isEmpty
                  ? const Center(
                      child: Text(
                        'No products found matching your search.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return ProductCard(product: product);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
