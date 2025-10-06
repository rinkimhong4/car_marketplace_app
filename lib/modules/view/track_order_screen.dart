import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackOrderScreen extends StatelessWidget {
  final String title;
  final String status;
  final String imageURL;
  final String price;
  final String carColor;

  const TrackOrderScreen({
    super.key,
    required this.title,
    required this.status,
    required this.imageURL,
    required this.price,
    required this.carColor,
  });

  List<String> _getSteps() {
    return ['Packing', 'Train', 'Customs', 'Delivery'];
  }

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

  int _getCurrentIndex(String status) {
    switch (status) {
      case 'Preparing':
        return 0;
      case 'In Delivery':
        return 1;
      case 'Delivered':
        return 3;
      default:
        return 0;
    }
  }

  List<Map<String, dynamic>> _getTimeline(String status) {
    switch (status) {
      case 'Preparing':
        return [
          {
            'icon': Icons.check_circle,
            'title': 'Verified Payments',
            'location': 'Gainesville, VA',
            'date': 'Dec 15',
            'time': '10:04 AM',
            'completed': true
          },
          {
            'icon': Icons.inventory_2,
            'title': 'Order in Packing',
            'location': 'Wheeling, WV',
            'date': 'Dec 15',
            'time': '10:25 AM',
            'completed': false
          },
          {
            'icon': Icons.train,
            'title': 'Orders are on Train',
            'location': 'Lake Zurich, IL',
            'date': 'Dec 15',
            'time': '11:30 AM',
            'completed': false
          },
          {
            'icon': Icons.account_balance,
            'title': 'Order at Customs Port',
            'location': 'Ringgold, GA',
            'date': 'Dec 16',
            'time': '14:40',
            'completed': false
          },
          {
            'icon': Icons.local_shipping,
            'title': 'Order Out for Delivery (Train)',
            'location': 'Ringgold, GA',
            'date': 'Dec 17',
            'time': '15:20',
            'completed': false
          },
        ];
      case 'In Delivery':
        return [
          {
            'icon': Icons.check_circle,
            'title': 'Verified Payments',
            'location': 'Gainesville, VA',
            'date': 'Dec 15',
            'time': '10:04 AM',
            'completed': false
          },
          {
            'icon': Icons.inventory_2,
            'title': 'Order in Packing',
            'location': 'Wheeling, WV',
            'date': 'Dec 15',
            'time': '10:25 AM',
            'completed': true
          },
          {
            'icon': Icons.train,
            'title': 'Orders are on Train',
            'location': 'Lake Zurich, IL',
            'date': 'Dec 15',
            'time': '11:30 AM',
            'completed': true
          },
          {
            'icon': Icons.account_balance,
            'title': 'Order at Customs Port',
            'location': 'Ringgold, GA',
            'date': 'Dec 16',
            'time': '14:40',
            'completed': false
          },
          {
            'icon': Icons.local_shipping,
            'title': 'Order Out for Delivery (Train)',
            'location': 'Ringgold, GA',
            'date': 'Dec 17',
            'time': '15:20',
            'completed': false
          },
        ];
      case 'Delivered':
        return [
          {
            'icon': Icons.check_circle,
            'title': 'Verified Payments',
            'location': 'Gainesville, VA',
            'date': 'Dec 15',
            'time': '10:04 AM',
            'completed': true
          },
          {
            'icon': Icons.inventory_2,
            'title': 'Order in Packing',
            'location': 'Wheeling, WV',
            'date': 'Dec 15',
            'time': '10:25 AM',
            'completed': true
          },
          {
            'icon': Icons.train,
            'title': 'Orders are on Train',
            'location': 'Lake Zurich, IL',
            'date': 'Dec 15',
            'time': '11:30 AM',
            'completed': true
          },
          {
            'icon': Icons.account_balance,
            'title': 'Order at Customs Port',
            'location': 'Ringgold, GA',
            'date': 'Dec 16',
            'time': '14:40',
            'completed': true
          },
          {
            'icon': Icons.local_shipping,
            'title': 'Order Out for Delivery (Train)',
            'location': 'Ringgold, GA',
            'date': 'Dec 17',
            'time': '15:20',
            'completed': true
          },
        ];
      default:
        return [];
    }
  }

  List<Widget> _buildTimeline(String status) {
    final timeline = _getTimeline(status);
    return timeline
        .map((item) =>
            _buildTimelineItem(item, timeline.indexOf(item), timeline.length))
        .toList();
  }

  Widget _buildTimelineItem(Map<String, dynamic> item, int index, int total) {
    final isLast = index == total - 1;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              item['completed']
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 24,
              color: Colors.grey,
            ),
            if (!isLast)
              Container(
                height: 40,
                width: 2,
                color: Colors.grey[300],
                margin: const EdgeInsets.symmetric(vertical: 4),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item['title']} - ${item['date']} ${item['time']}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: item['completed'] ? Colors.black : Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item['location'],
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${item['date']} at ${item['time']}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final steps = _getSteps();
    final currentIndex = _getCurrentIndex(status);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Track Order'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageURL,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            // Title and Price
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              price,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Color: $carColor',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                    color: _getColorFromName(carColor),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Progress Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < steps.length; i++) ...[
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            [
                              Icons.inventory_2,
                              Icons.train,
                              Icons.account_balance,
                              Icons.local_shipping
                            ][i],
                            size: 32,
                            color:
                                i <= currentIndex ? Colors.black : Colors.grey,
                          ),
                          if (i <= currentIndex)
                            const Icon(
                              Icons.check,
                              size: 20,
                              color: Colors.white,
                            ),
                        ],
                      ),
                      Container(
                        height: 2,
                        width: 40,
                        color: i <= currentIndex
                            ? Colors.black
                            : Colors.transparent,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        steps[i],
                        style: TextStyle(
                          fontSize: 12,
                          color: i <= currentIndex ? Colors.black : Colors.grey,
                          fontWeight: i <= currentIndex
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  if (i < steps.length - 1)
                    Container(
                      width: 40,
                      height: 2,
                      color: i < currentIndex ? Colors.black : Colors.grey,
                    ),
                ],
              ],
            ),
            const SizedBox(height: 24),
            // Current Status
            Text(
              'Car $status (${steps[currentIndex]})',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            // Order Status Details Header
            const Text(
              'Order Status Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),
            // Timeline
            ..._buildTimeline(status),
          ],
        ),
      ),
    );
  }
}
