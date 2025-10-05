import 'package:flutter/material.dart';

/// Represents detailed information about a car product for display in the app.
class ProductDetail {
  final String title;
  final String description;
  final double price;
  final double rating;
  final int reviewCount;
  final List<String> galleryImages;
  final List<Color> availableColors;
  final String model3dUrl;
  final String storeName;
  final String storeLogo;
  final String storeDescription;
  final String brand;
  final String condition;

  /// Creates a [ProductDetail] instance.
  const ProductDetail({
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.galleryImages,
    required this.availableColors,
    required this.model3dUrl,
    required this.storeName,
    required this.storeLogo,
    required this.storeDescription,
    required this.brand,
    required this.condition,
  });
}

// Hardcoded BMW M5 data
const ProductDetail bmwM5Detail = ProductDetail(
  title: 'BMW M5 Series',
  description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...',
  price: 175000,
  rating: 4.8,
  reviewCount: 86,
  galleryImages: [
    'assets/images/car.png',
    'assets/images/car.png',
    'assets/images/car.png',
    'assets/images/car.png',
    'assets/images/car.png',
  ],
  availableColors: [
    Color(0xFF8B4513), // Brown
    Color(0xFF808080), // Gray
    Color(0xFFC0C0C0), // Light gray
    Color(0xFF4682B4), // Blue-gray
  ],
  model3dUrl: 'assets/3d/sport.glb',
  storeName: 'BMW Store',
  storeLogo: '',
  storeDescription: 'Official Account of BMW',
  brand: 'BMW',
  condition: 'New',
);
