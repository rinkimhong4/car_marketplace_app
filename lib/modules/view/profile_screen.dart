import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_marketplace_app/config/theme/theme_style.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
        'Profile',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      centerTitle: false,
      leading: const Icon(
        Icons.car_crash_sharp,
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18, top: 20),
        child: Column(
          children: [_buildAvatar, _buildListTitle(context)],
        ),
      ),
    );
  }

  get _buildAvatar {
    return Center(
      child: Column(
        spacing: 10,
        children: [
          Stack(
            children: [
              const CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                    'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                radius: 68,
              ),
              // Edit, For change profile pic
              Positioned(
                  bottom: 0,
                  right: 10,
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.black,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.edit,
                        size: 20,
                      ),
                    ),
                  )),
            ],
          ),
          Text(
            'Rin Kimhong',
            style: AppTextStyle.bold18(color: Colors.black),
          ),
          Text(
            'RinKimhong4@gmail.com',
            style: AppTextStyle.regular14(color: Colors.black),
          ),
          const Divider(
            color: Colors.black26,
          )
        ],
      ),
    );
  }

  Widget _buildListTitle(BuildContext context) {
    final List<Map<String, dynamic>> listTitle = [
      {'icon': Icons.person_2_outlined, 'title': 'Edit Profile'},
      {'icon': Icons.location_on_outlined, 'title': 'Address'},
      {'icon': Icons.notifications_outlined, 'title': 'Notifications'},
      {'icon': Icons.payment_rounded, 'title': 'Payment'},
      {'icon': Icons.lock_outline, 'title': 'Security'},
      {'icon': Icons.language_outlined, 'title': 'Language'},
      {
        'icon': Icons.dark_mode_outlined,
        'title': 'Dark Mode',
        'isSwitch': true
      },
      {'icon': Icons.privacy_tip_outlined, 'title': 'Privacy Policy'},
      {'icon': Icons.help_outline, 'title': 'Help Center'},
      {'icon': Icons.person_add_alt_1_outlined, 'title': 'Invite Friend'},
    ];

    bool isDarkMode = true;

    return Column(
      children: [
        ...List.generate(listTitle.length, (index) {
          final item = listTitle[index];

          // Dark mode switch tile
          if (item['isSwitch'] == true) {
            return SwitchListTile(
              secondary: Icon(item['icon']),
              title: Text(item['title']),
              value: isDarkMode,
              onChanged: (value) {
                //  Handle dark mode toggle
              },
            );
          }

          // Regular list tiles
          return ListTile(
            leading: Icon(item['icon']),
            title: Text(
              item['title'],
              style: AppTextStyle.regular16(color: Colors.black),
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 28,
            ),
            onTap: () {},
            //
          );
        }),

        //  Logout tile (special styling)
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.redAccent),
          title: const Text(
            'Logout',
            style:
                TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600),
          ),
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 10,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Logout',
                      style: AppTextStyle.bold16(color: Colors.red),
                    ),
                    const Divider(
                      color: Colors.black12,
                    ),
                    Text(
                      'Are you want to logout?',
                      style: AppTextStyle.bold16(color: Colors.black),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Cancel Button
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.grey[600],
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),

                            // Logout Button
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                //  Add logout logic here
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Yes, Logout',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
