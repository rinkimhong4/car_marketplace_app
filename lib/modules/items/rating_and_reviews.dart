import 'package:flutter/material.dart';

class RatingAndReviews extends StatelessWidget {
  const RatingAndReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: const _BuildBody(),
    );
  }

  /// --- AppBar Block ---
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Reviews',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      centerTitle: false,
      leading: const Icon(
        Icons.car_crash,
        color: Colors.black,
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
    return const Placeholder();
  }
}
