import 'package:car_marketplace_app/config/theme/theme_style.dart';
import 'package:car_marketplace_app/core/data/data.dart';
import 'package:car_marketplace_app/config/routes/app_routes.dart';
import 'package:flutter/material.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

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
        'Inbox',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      centerTitle: false,
      leading: const Icon(
        Icons.inbox,
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
    final chats = Datas.inboxList[0]['data']?['chats'] as List<dynamic>;
    final calls = Datas.inboxList[0]['data']?['calls'] as List<dynamic>;

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          // --- TabBar ---
          const TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'Chats'),
              Tab(text: 'Calls'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // --- Chats Tab ---
                ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    return ListTile(
                      leading: Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(chat['profileImage']),
                            radius: 25,
                          ),
                          if (chat['isOnline'] == true)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 1.5),
                                ),
                              ),
                            ),
                        ],
                      ),
                      title: Text(
                        chat['name'],
                        style: AppTextStyle.bold16(color: Colors.black),
                      ),
                      subtitle: Text(
                        chat['message'],
                        style: AppTextStyle.regular13(color: Colors.grey[800]!),
                      ),
                      trailing: Column(
                        spacing: 4,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (chat['unreadCount'] > 0)
                            Container(
                              height: 18,
                              width: 18,
                              decoration: const BoxDecoration(
                                  color: Colors.black, shape: BoxShape.circle),
                              child: Center(
                                child: Text(
                                  '${chat['unreadCount']}',
                                  style: AppTextStyle.regular10(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          Text(
                            chat['time'],
                            style: AppTextStyle.regular11(color: Colors.grey),
                          ),
                        ],
                      ),
                      onTap: () {
                        RouteView.chatView.go(arguments: {
                          'name': chat['name'],
                          'profileImage': chat['profileImage']
                        });
                      },
                    );
                  },
                ),

                // --- Calls Tab ---
                ListView.builder(
                  itemCount: calls.length,
                  itemBuilder: (context, index) {
                    final call = calls[index];
                    IconData callIcon;
                    Color iconColor;

                    switch (call['status']) {
                      case 'missed':
                        callIcon = Icons.call_missed;
                        iconColor = Colors.red;
                        break;
                      case 'outgoing':
                        callIcon = Icons.call_made;
                        iconColor = Colors.green;
                        break;
                      case 'incoming':
                        callIcon = Icons.call_received;
                        iconColor = Colors.blue;
                        break;
                      default:
                        callIcon = Icons.call;
                        iconColor = Colors.grey;
                    }

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(call['profileImage']),
                        radius: 25,
                      ),
                      title: Text(
                        call['name'],
                        style: AppTextStyle.bold16(color: Colors.black),
                      ),
                      subtitle: Text(
                        '${call['callType']} • ${call['duration']}',
                        style: AppTextStyle.regular13(color: Colors.grey[800]!),
                      ),
                      trailing: Column(
                        spacing: 4,
                        children: [
                          Icon(callIcon, color: iconColor),
                          Text(
                            call['time'],
                            style: AppTextStyle.regular11(color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatViewScreen extends StatelessWidget {
  const ChatViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
