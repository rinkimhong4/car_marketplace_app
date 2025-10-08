// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_marketplace_app/config/theme/theme_style.dart';
import 'package:car_marketplace_app/modules/view/track_order_screen.dart';
import 'package:car_marketplace_app/widget/leave_review_button.dart';
import 'package:car_marketplace_app/widget/track_order_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart' as rating_dialog;

class OrderCardWidget extends StatelessWidget {
  final String title;
  final String imageURL;
  final String carColor;
  final String status;
  final String price;

  const OrderCardWidget({
    super.key,
    required this.title,
    required this.imageURL,
    required this.carColor,
    required this.status,
    required this.price,
  });

  // Convert color name to Flutter Color
  Color _getColorFromName(String name) {
    switch (name.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'silver':
        return Colors.grey;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  void _showRatingDialog(
      BuildContext context, String title, String imageURL, String price) {
    final dialog = rating_dialog.RatingDialog(
      initialRating: 1.0,
      title: Text('Leave a review',
          textAlign: TextAlign.center,
          style: AppTextStyle.medium28(color: Colors.black)),
      message: Text(
          'Tap a star to set your rating. Add more description here if you want.',
          textAlign: TextAlign.center,
          style: AppTextStyle.regular14(color: Colors.black)),
      image: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imageURL),
          ),
        ),
      ),
      submitButtonText: 'Submit',
      commentHint: 'Please provide your feedback',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');
        // Navigator.of(context).pop();
        Get.snackbar('Thank you!', 'Your review has been submitted.');
      },
    );

    showDialog(context: context, builder: (context) => dialog);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        spacing: 20,
        children: [
          // --- Image ---
          Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(
                image: CachedNetworkImageProvider(imageURL),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // --- Info Section ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.split(' ').take(3).join(' '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    // Car color circle
                    Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        color: _getColorFromName(carColor),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black12),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      carColor[0].toUpperCase() + carColor.substring(1),
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 24,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        status,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 14),
                    status == 'Completed'
                        ? LeaveReviewButton(
                            onPressed: () {
                              _showRatingDialog(
                                  context, title, imageURL, price);
                            },
                          )
                        : TrackOrderButton(
                            onPressed: () {
                              Get.to(TrackOrderScreen(
                                title: title,
                                status: status,
                                imageURL: imageURL,
                                price: price,
                                carColor: carColor,
                              ));
                            },
                          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
