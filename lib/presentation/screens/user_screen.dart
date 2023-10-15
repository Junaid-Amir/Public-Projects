import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/constants/colors.dart';
import '../../helper/constants/utils.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 31),
              width: Get.width,
              height: Get.height * 0.27,
              color: Colors.black.withOpacity(0.45),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textUtils.textBold20(text: 'Account'),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.settings,
                          color: AppColors.textWhiteColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                            //  'https://cdn.icon-icons.com/icons2/2468/PNG/512/user_icon_149329.png'),
                            'https://encrypted-tbn1.gstatic.com/licensed-image?q=tbn:ANd9GcTdmMxn0Oj1DJC3c4wxCqeM3f3vy5YVyi2ljCHxHTixw1rfMSw0hfiTbAakWQZs0smgXHF16FOrRhQ-0Ac'),
                      ),
                      const SizedBox(
                        width: 21,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textUtils.textBold20(text: 'John Doe'),
                          const SizedBox(
                            height: 4,
                          ),
                          textUtils.textBold14(text: 'johndoe@gmail.com'),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit_note_sharp,
                          color: AppColors.textWhiteColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 31,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: textUtils.textBold16(
                text: 'General Settings',
                color: Colors.deepOrangeAccent,
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            customLisTile(
              onTap: () {},
              leadingIconData: Icons.notifications_outlined,
              title: 'Notifications',
            ),
            customLisTile(
              onTap: () {},
              leadingIconData: Icons.subscriptions_outlined,
              title: 'My Subscription Plan',
            ),
            customLisTile(
              onTap: () {},
              leadingIconData: Icons.history_toggle_off_rounded,
              title: 'Transaction History',
            ),
            customLisTile(
              onTap: () {},
              leadingIconData: Icons.next_plan_outlined,
              title: 'My Subscription Plan',
            ),
            const SizedBox(
              height: 21,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: textUtils.textBold16(
                text: 'Profile Settings',
                color: Colors.deepOrangeAccent,
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            customLisTile(
              onTap: () {},
              leadingIconData: Icons.subscriptions_outlined,
              title: 'Watch History',
            ),
            customLisTile(
              onTap: () {},
              leadingIconData: Icons.pause_presentation_outlined,
              title: 'Following',
            ),
            customLisTile(
              onTap: () {},
              leadingIconData: Icons.favorite_border_outlined,
              title: 'Liked Movies',
            ),
            const SizedBox(
              height: 11,
            ),
          ],
        ),
      ),
    );
  }

  Widget customLisTile({
    required IconData leadingIconData,
    required String title,
    required void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          leadingIconData,
          color: Colors.deepOrangeAccent,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
