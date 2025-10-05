import 'package:flutter/material.dart';

class Car {
  final String imageUrl;
  final String title;
  final String brand;
  final int year;
  final double rating;
  final int reviewCount;
  final String condition;
  final double price;
  final int mileage;
  final String description;
  final bool isFavorite;
  final List<String> galleryImages;
  final List<Color> availableColors;
  final String model3dUrl;

  Car({
    required this.imageUrl,
    required this.title,
    required this.brand,
    required this.year,
    required this.rating,
    this.reviewCount = 0,
    required this.condition,
    required this.price,
    required this.mileage,
    required this.description,
    required this.isFavorite,
    this.galleryImages = const [],
    this.availableColors = const [],
    this.model3dUrl = '',
  });
}

class FilterData {
  final Set<String> selectedBrands;
  final Set<String> selectedConditions;
  final Set<String> selectedRatings;
  final String selectedSort;
  final RangeValues priceRange;

  const FilterData({
    required this.selectedBrands,
    required this.selectedConditions,
    required this.selectedRatings,
    required this.selectedSort,
    required this.priceRange,
  });
}
