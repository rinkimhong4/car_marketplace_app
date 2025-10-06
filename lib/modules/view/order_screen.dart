import 'package:car_marketplace_app/widget/order_card_widget.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

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
        'My Orders',
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

/// --- Body Block ---
class _BuildBody extends StatelessWidget {
  const _BuildBody();

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Column(
        children: [
          // --- TabBar ---
          TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
            ],
          ),

          // --- TabBar Views ---
          Expanded(
            child: TabBarView(
              children: [
                // Active Orders
                SingleChildScrollView(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    children: [
                      OrderCardWidget(
                        title: 'Officially Licensed BMW M8 GTE',
                        imageURL:
                            'https://m.media-amazon.com/images/I/61oqmbe5Q1L._UF1000,1000_QL80_.jpg',
                        carColor: 'Red',
                        status: 'In Delivery',
                        price: '\$171,250',
                      ),
                      SizedBox(height: 20),
                      OrderCardWidget(
                        title: 'Porsche Taycan Turbo S',
                        imageURL:
                            'https://m.media-amazon.com/images/I/61oqmbe5Q1L._UF1000,1000_QL80_.jpg',
                        carColor: 'Silver',
                        status: 'Preparing',
                        price: '\$171,250',
                      ),
                    ],
                  ),
                ),

                // Completed Orders
                SingleChildScrollView(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    children: [
                      OrderCardWidget(
                        title: 'Tesla Model X Plaid',
                        imageURL:
                            'https://m.media-amazon.com/images/I/61oqmbe5Q1L._UF1000,1000_QL80_.jpg',
                        carColor: 'White',
                        status: 'Completed',
                        price: '\$171,250',
                      ),
                    ],
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
