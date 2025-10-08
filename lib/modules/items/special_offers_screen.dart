import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class SpecialOffersScreen extends StatelessWidget {
  const SpecialOffersScreen({super.key});

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
        'Notofications',
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
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      if (_pageController.page != null) {
        setState(() {
          _currentIndex = _pageController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _offers = [
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=400&h=200&fit=crop',
      'discount': '30%',
      'title': 'SUV Specials!',
      'subtitle': 'Get BMW X5 at unbeatable prices, limited time offer',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1503602642458-232111445657?w=400&h=200&fit=crop',
      'discount': 'Free',
      'title': 'Test Drive!',
      'subtitle': 'Experience the Tesla Model 3 with no cost today',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=400&h=200&fit=crop',
      'discount': '20%',
      'title': 'Service Discount',
      'subtitle': 'Maintenance check for your Honda Civic, book now',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=400&h=200&fit=crop',
      'discount': '15%',
      'title': 'Accessories Sale!',
      'subtitle': 'Upgrade your ride with discounted car accessories',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 20,
        children: List.generate(
            _offers.length,
            (index) => SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _offers.length,
                    itemBuilder: (context, index) {
                      final offer = _offers[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // Full background image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                imageUrl: offer['imageUrl'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                placeholder: (context, url) => Container(
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.error),
                                ),
                              ),
                            ),

                            // Dark overlay to make text readable
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.black.withValues(alpha: 0.3),
                              ),
                            ),
                            // Text on top of image
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    offer['discount'],
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    offer['title'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    offer['subtitle'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // DotsIndicator at bottom center
                            Positioned(
                              bottom: 8,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: DotsIndicator(
                                  dotsCount: _offers.length,
                                  position: _currentIndex,
                                  decorator: DotsDecorator(
                                    activeColor: Colors.white,
                                    color: Colors.white54,
                                    spacing: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    activeSize: const Size(12, 6),
                                    size: const Size(8, 6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    activeShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )),
      ),
    );
  }
}
