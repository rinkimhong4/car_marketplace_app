import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_marketplace_app/config/routes/app_routes.dart';
import 'package:car_marketplace_app/config/theme/theme_style.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class SpecialOffersBanner extends StatefulWidget {
  const SpecialOffersBanner({super.key});

  @override
  State<SpecialOffersBanner> createState() => _SpecialOffersBannerState();
}

class _SpecialOffersBannerState extends State<SpecialOffersBanner> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  int selectedIndex = 0;

  final List<Map<String, dynamic>> _offers = [
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=400&h=200&fit=crop',
      'discount': '20%',
      'title': 'Week Deals!',
      'subtitle': 'Get a new car discount, only valid this week',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=400&h=200&fit=crop',
      'discount': '20%',
      'title': 'Week Deals!',
      'subtitle': 'Get a new car discount, only valid this week',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=400&h=200&fit=crop',
      'discount': '20%',
      'title': 'Week Deals!',
      'subtitle': 'Get a new car discount, only valid this week',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=400&h=200&fit=crop',
      'discount': '20%',
      'title': 'Week Deals!',
      'subtitle': 'Get a new car discount, only valid this week',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=400&h=200&fit=crop',
      'discount': '20%',
      'title': 'Week Deals!',
      'subtitle': 'Get a new car discount, only valid this week',
    },
  ];
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

  final List<String> logos = [
    "https://cdn.iconscout.com/icon/free/png-256/free-mercedes-3-202854.png",
    "https://static.vecteezy.com/system/resources/previews/020/336/484/non_2x/tesla-logo-tesla-icon-transparent-png-free-vector.jpg",
    "https://cdn.iconscout.com/icon/free/png-256/free-bmw-5-202750.png",
    "https://cdn.iconscout.com/icon/free/png-256/free-toyota-7-202873.png",
    "https://cdn.iconscout.com/icon/free/png-256/free-volvo-6-202861.png",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNKD9lCNuthEhRwkZy0MlWEolEcmNl2fa3nMX1km_4alsFkKp6CvxxqDKJTvF5RunqqOw&usqp=CAU",
    "https://cdn.iconscout.com/icon/free/png-256/free-honda-11-202870.png",
    "https://cdn-icons-png.flaticon.com/512/61/61112.png",
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page!.round() != _currentIndex) {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Special Offers',
                style: AppTextStyle.medium18(color: Colors.black),
              ),
              TextButton(
                onPressed: () {
                  RouteView.specialOffers.go();
                },
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

        // PageView with image background and text overlay
        SizedBox(
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
                            spacing: const EdgeInsets.symmetric(horizontal: 4),
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
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            slivers: [
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withValues(alpha: 0.3),
                          ),
                          child: Center(
                            child: index == 7
                                ? const Icon(
                                    Icons.more_horiz,
                                    color: Colors.black,
                                    size: 30,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: logos[
                                        index < 4 ? index : index - 4 + 4],
                                    fit: BoxFit.contain,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          index == 7
                              ? 'More'
                              : names[index < 4 ? index : index - 4 + 4],
                          style: AppTextStyle.regular11(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                  childCount: 8,
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Deals',
                style: AppTextStyle.medium18(color: Colors.black),
              ),
              TextButton(
                onPressed: () {
                  RouteView.topDeals.go();
                },
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: List.generate(
                names.length,
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
                        index == 0 ? 'All' : names[index],
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
        )
      ],
    );
  }
}
