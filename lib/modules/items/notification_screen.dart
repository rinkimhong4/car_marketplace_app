import 'package:car_marketplace_app/config/theme/theme_style.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
            Icons.circle_notifications,
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

  static var notificationData = {
    'data': {
      'new': {
        'categoryName': 'Today',
        'datas': [
          {
            'title': 'Your Test Drive is Confirmed!',
            'description':
                'Hi Sithy, your test drive for the Toyota Corolla is confirmed for 4:00 PM today. Please arrive 10 minutes early.',
            'icon': 'assets/icons/steering.png', // optional icon path
            'time': '2h',
          },
          {
            'title': 'Service Reminder',
            'description':
                'Your Honda Civic is due for a maintenance check. Book your service today and get 15% off labor costs!',
            'icon': 'assets/icons/service.png',
            'time': '3h',
          },
        ],
      },
      'today': {
        'categoryName': 'Yesterday',
        'datas': [
          {
            'title': 'Special Offer: Car Wash Discount',
            'description':
                'Enjoy a 50% discount on car wash services this week only. Keep your ride shining!',
            'icon': 'assets/icons/offer.png',
            'time': '8h',
          },
          {
            'title': 'Order Update',
            'description':
                'Your car accessories order #1453 has been shipped and is on its way!',
            'icon': 'assets/icons/shipped.png',
            'time': '10h',
          },
        ],
      },
      'earlier': {
        'categoryName': 'Oct 6, 2025',
        'datas': [
          {
            'title': 'Price Drop Alert!',
            'description':
                'The BMW X5 you viewed last week has dropped \$2,000 in price. Limited stock available!',
            'icon': 'assets/icons/price_drop.png',
            'time': '2d',
          },
          {
            'title': 'New Arrival: Tesla Model Y',
            'description':
                'Check out the all-new Tesla Model Y now available at our showroom. Schedule a test drive today!',
            'icon': 'assets/icons/new_car.png',
            'time': '2d',
          },
          {
            'title': 'Payment Confirmation',
            'description':
                'Your payment for the Toyota Hilux accessories has been successfully processed. Thank you for shopping with us!',
            'icon': 'assets/icons/payment.png',
            'time': '2d',
          },
        ],
      },
    },
  };

  @override
  Widget build(BuildContext context) {
    final data = notificationData['data'] as Map<String, dynamic>;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      child: ListView(
        children: data.entries.map((category) {
          final categoryName = category.value['categoryName'];
          final items = category.value['datas'] as List<dynamic>;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🏷 Category title
              Text(
                categoryName,
                style: AppTextStyle.medium18(color: Colors.black),
              ),
              const SizedBox(height: 10),

              // 🔔 Notification items
              ...items.map((item) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🔘 Icon
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: const Center(
                          child: Icon(Icons.notifications, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // 📄 Notification info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'],
                              style: AppTextStyle.medium18(color: Colors.black),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['description'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.regular12(
                                  color: Colors.grey[800]),
                            ),
                            const SizedBox(height: 8),

                            // 🕒 Time and button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['time'],
                                  style: AppTextStyle.regular12(
                                      color: Colors.grey[600]),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    side: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                  ),
                                  child: const Text('View Details'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),
            ],
          );
        }).toList(),
      ),
    );
  }
}
