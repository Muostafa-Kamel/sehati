import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopBar {
  static Widget buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.notifications_active, size: 28),
        const Text(
          'صـــحـــّـتـي',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        // مساحة فاضية عشان العنوان يفضل في النص تماماً زي التصميم
        const SizedBox(width: 28),
      ],
    );
  }
}