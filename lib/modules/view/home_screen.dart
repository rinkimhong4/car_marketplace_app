import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_marketplace_app/config/theme/theme_style.dart';
import 'package:car_marketplace_app/modules/view/card.dart';
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
    final cars = [
      {
        'imageUrl':
            'https://cdn.motor1.com/images/mgl/L3kL4W/s3/lamborghini-revuelto.jpg',
        'title': 'Toyota Camry',
        'rating': 4.5,
        'condition': 'New',
        'price': 25000,
        'isFavorite': false,
      },
      {
        'imageUrl':
            'https://cdn.motor1.com/images/mgl/L3kL4W/s3/lamborghini-revuelto.jpg',
        'title': 'Honda Civic',
        'rating': 4.2,
        'condition': 'Used',
        'price': 18000,
        'isFavorite': true,
      },
      {
        'imageUrl':
            'https://cdn.motor1.com/images/mgl/L3kL4W/s3/lamborghini-revuelto.jpg',
        'title': 'Ford Mustang',
        'rating': 4.8,
        'condition': 'New',
        'price': 35000,
        'isFavorite': false,
      },
      {
        'imageUrl':
            'https://cdn.motor1.com/images/mgl/L3kL4W/s3/lamborghini-revuelto.jpg',
        'title': 'BMW 3 Series',
        'rating': 4.7,
        'condition': 'New',
        'price': 40000,
        'isFavorite': false,
      },
      {
        'imageUrl':
            'https://cdn.motor1.com/images/mgl/L3kL4W/s3/lamborghini-revuelto.jpg',
        'title': 'BMW 3 Series',
        'rating': 4.7,
        'condition': 'New',
        'price': 40000,
        'isFavorite': false,
      },
    ];

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
            final car = cars[index];
            return CarCard(
              imageUrl: car['imageUrl'] as String,
              title: car['title'] as String,
              rating: car['rating'] as double,
              condition: car['condition'] as String,
              price: (car['price'] as num).toDouble(),
              isFavorite: car['isFavorite'] as bool,
            );
          },
          childCount: cars.length,
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
            //
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
            //
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
                final query = _searchController.text;
                if (query.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchResultScreen(searchQuery: query),
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
            if (value.isNotEmpty) {
              // Navigate to search result screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchResultScreen(searchQuery: value),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class SearchResultScreen extends StatefulWidget {
  final String searchQuery;

  const SearchResultScreen({super.key, required this.searchQuery});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late final TextEditingController _searchController;
  late String currentQuery;

  @override
  void initState() {
    super.initState();
    currentQuery = widget.searchQuery;
    _searchController = TextEditingController(text: currentQuery);
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              child: Center(
                child: Text(
                  'Display results for: $currentQuery',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistogramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.grey.withValues(alpha: 0.3);
    final random = Random();
    final barWidth = size.width / 20;
    for (int i = 0; i < 20; i++) {
      final height = random.nextDouble() * size.height;
      canvas.drawRect(
        Rect.fromLTWH(i * barWidth, size.height - height, barWidth, height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final List<String> brands = [
    'Mercedes',
    'Tesla',
    'BMW',
    'BMW',
    'BMW',
    'BMW',
    'BMW'
  ];
  final List<String> conditions = ['New', 'Used'];
  final List<String> ratings = ['5', '4', '3', '2'];
  final List<String> sortOptions = ['Popular', 'Most Recent', 'Price High'];

  Set<String> selectedBrands = <String>{};
  Set<String> selectedConditions = <String>{};
  Set<String> selectedRatings = <String>{};
  String? selectedSort = 'Most Recent';
  RangeValues _currentRangeValues = const RangeValues(80000, 200000);

  Widget _buildCustomChip({
    required Widget child,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? Colors.black : Colors.grey.shade300,
          ),
        ),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Wrap(
          spacing: 8.0,
          children: children,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sort & Filter'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                _buildFilterSection('Car Brands', [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 10,
                      children: [
                        _buildCustomChip(
                          child: const Text('All'),
                          selected: selectedBrands.isEmpty,
                          onTap: () {
                            setState(() {
                              selectedBrands.clear();
                            });
                          },
                        ),
                        ...brands.map((brand) => _buildCustomChip(
                              child: Text(brand),
                              selected: selectedBrands.contains(brand),
                              onTap: () {
                                setState(() {
                                  if (selectedBrands.contains(brand)) {
                                    selectedBrands.remove(brand);
                                  } else {
                                    selectedBrands.add(brand);
                                  }
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                ]),
                _buildFilterSection('Car Condition', [
                  _buildCustomChip(
                    child: const Text('All'),
                    selected: selectedConditions.isEmpty,
                    onTap: () {
                      setState(() {
                        selectedConditions.clear();
                      });
                    },
                  ),
                  ...conditions.map((condition) => _buildCustomChip(
                        child: Text(condition),
                        selected: selectedConditions.contains(condition),
                        onTap: () {
                          setState(() {
                            if (selectedConditions.contains(condition)) {
                              selectedConditions.remove(condition);
                            } else {
                              selectedConditions.add(condition);
                            }
                          });
                        },
                      )),
                ]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Price Range',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: Stack(
                        children: [
                          CustomPaint(
                            painter: HistogramPainter(),
                            size: Size.infinite,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: RangeSlider(
                              values: _currentRangeValues,
                              min: 0,
                              max: 300000,
                              divisions: 30,
                              labels: RangeLabels(
                                '\$${(_currentRangeValues.start / 1000).round()}K',
                                '\$${(_currentRangeValues.end / 1000).round()}K',
                              ),
                              onChanged: (values) {
                                setState(() {
                                  _currentRangeValues = values;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '\$${(_currentRangeValues.start / 1000).round()}K'),
                        Text('\$${(_currentRangeValues.end / 1000).round()}K'),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                _buildFilterSection('Sort by', [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 10,
                      children: sortOptions
                          .map((option) => _buildCustomChip(
                                child: Text(option),
                                selected: selectedSort == option,
                                onTap: () {
                                  setState(() {
                                    selectedSort = option;
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ),
                ]),
                _buildFilterSection('Rating', [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 10,
                      children: [
                        _buildCustomChip(
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, size: 16, color: Colors.black),
                              SizedBox(width: 4),
                              Text('All'),
                            ],
                          ),
                          selected: selectedRatings.isEmpty,
                          onTap: () {
                            setState(() {
                              selectedRatings.clear();
                            });
                          },
                        ),
                        ...ratings.map((rating) => _buildCustomChip(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.star,
                                      size: 16, color: Colors.black),
                                  Text(rating),
                                ],
                              ),
                              selected: selectedRatings.contains(rating),
                              onTap: () {
                                setState(() {
                                  if (selectedRatings.contains(rating)) {
                                    selectedRatings.remove(rating);
                                  } else {
                                    selectedRatings.add(rating);
                                  }
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedBrands.clear();
                        selectedConditions.clear();
                        selectedRatings.clear();
                        selectedSort = 'Most Recent';
                        _currentRangeValues = const RangeValues(0, 300000);
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                    ),
                    child: const Text('Reset'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Apply filters logic here
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
