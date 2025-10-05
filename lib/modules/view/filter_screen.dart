import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final List<String> brands = [
    'Toyota',
    'Honda',
    'Ford',
    'BMW',
    'Mercedes',
    'Tesla',
    'Hyundai',
    'Volkswagen',
    'Porsche',
    'Chevrolet'
  ];
  final List<String> conditions = ['New', 'Used'];
  final List<String> ratings = ['5', '4', '3', '2'];
  final List<String> sortOptions = ['Popular', 'Most Recent', 'Price High'];

  Set<String> selectedBrands = <String>{};
  Set<String> selectedConditions = <String>{};
  Set<String> selectedRatings = <String>{};
  String selectedSort = 'Most Recent';
  RangeValues _currentRangeValues = const RangeValues(80000, 200000);

  TextStyle get titleText => GoogleFonts.inter(
      fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black);

  TextStyle get bodyText => GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black);

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
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? Colors.black : Colors.grey.shade300,
          ),
        ),
        child: DefaultTextStyle.merge(
          style:
              bodyText.copyWith(color: selected ? Colors.black : Colors.white),
          child: child,
        ),
      ),
    );
  }

  List<Widget> _buildHorizontalChips(
      List<String> options, bool isRating, bool isCondition) {
    List<Widget> children = [];

    // "All" chip
    Widget allChild = isRating
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, size: 16, color: Colors.black),
              const SizedBox(width: 4),
              Text('All', style: bodyText),
            ],
          )
        : Text('All', style: bodyText);

    Set<String>? selectedSetForAll;
    VoidCallback? onTapForAll;

    if (isRating) {
      selectedSetForAll = selectedRatings;
      onTapForAll = () => setState(() => selectedRatings.clear());
    } else if (isCondition) {
      selectedSetForAll = selectedConditions;
      onTapForAll = () => setState(() => selectedConditions.clear());
    } else {
      selectedSetForAll = selectedBrands;
      onTapForAll = () => setState(() => selectedBrands.clear());
    }

    children.add(_buildCustomChip(
      child: allChild,
      selected: selectedSetForAll.isEmpty,
      onTap: onTapForAll,
    ));

    for (final option in options) {
      children.add(const SizedBox(width: 10));

      Widget chipChild = isRating
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, size: 16, color: Colors.black),
                const SizedBox(width: 4),
                Text(option, style: bodyText),
              ],
            )
          : Text(option, style: bodyText);

      Set<String>? selectedSet;
      VoidCallback? onTapCallback;

      if (isRating) {
        selectedSet = selectedRatings;
        onTapCallback = () {
          setState(() {
            if (selectedRatings.contains(option)) {
              selectedRatings.remove(option);
            } else {
              selectedRatings.add(option);
            }
          });
        };
      } else if (isCondition) {
        selectedSet = selectedConditions;
        onTapCallback = () {
          setState(() {
            if (selectedConditions.contains(option)) {
              selectedConditions.remove(option);
            } else {
              selectedConditions.add(option);
            }
          });
        };
      } else {
        selectedSet = selectedBrands;
        onTapCallback = () {
          setState(() {
            if (selectedBrands.contains(option)) {
              selectedBrands.remove(option);
            } else {
              selectedBrands.add(option);
            }
          });
        };
      }

      children.add(_buildCustomChip(
        child: chipChild,
        selected: selectedSet.contains(option),
        onTap: onTapCallback,
      ));
    }
    return children;
  }

  List<Widget> _buildSortChips() {
    return sortOptions.map((option) {
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: _buildCustomChip(
          child: Text(option, style: bodyText),
          selected: selectedSort == option,
          onTap: () => setState(() => selectedSort = option),
        ),
      );
    }).toList();
  }

  Widget _buildFilterSection(String title, List<Widget> sectionContent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(title, style: titleText),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: sectionContent),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sort & Filter',
            style: titleText.copyWith(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                _buildFilterSection(
                    'Car Brands', _buildHorizontalChips(brands, false, false)),
                _buildFilterSection('Car Condition',
                    _buildHorizontalChips(conditions, false, true)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Price Range', style: titleText),
                    ),
                    SizedBox(
                      height: 48,
                      child: Stack(
                        children: [
                          CustomPaint(
                              painter: HistogramPainter(), size: Size.infinite),
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
                              onChanged: (values) =>
                                  setState(() => _currentRangeValues = values),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$${(_currentRangeValues.start / 1000).round()}K',
                            style: bodyText),
                        Text('\$${(_currentRangeValues.end / 1000).round()}K',
                            style: bodyText),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                _buildFilterSection('Sort by', _buildSortChips()),
                _buildFilterSection(
                    'Rating', _buildHorizontalChips(ratings, true, false)),
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
                    child: Text('Reset', style: bodyText),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Apply',
                        style: bodyText.copyWith(color: Colors.white)),
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
