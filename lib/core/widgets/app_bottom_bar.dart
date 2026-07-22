import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sehati/screens/appointments_screen.dart';
import 'package:sehati/screens/search_screeen.dart';

import '../app_colors.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({super.key});

  static const Color tealColor = AppColors.primary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.person_outline, size: 26),
          GestureDetector(
            child: const Icon(Icons.calendar_today_outlined, size: 24),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppointmentsScreen()),
              );
            },
          ),
          GestureDetector(
            child: const Icon(Icons.search, size: 26),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
          // الزر البارز بتاع "الرئيسية"
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: tealColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child:  Row(
              children: [
                Text(
                  'الرئيسية',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.home_rounded, color: Colors.white, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
