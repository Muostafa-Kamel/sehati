import 'package:flutter/material.dart';
import 'package:sehati/screens/appointments_screen.dart';
import 'package:sehati/screens/homepage.dart';
import 'package:sehati/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  static const Color tealColor = Color(0xFF1FA7A0);

  @override
  Widget build(BuildContext context) {
    final doctors = const [
      DoctorResult(
        name: 'خالد علي عبدالله',
        specialty: 'دكتور قلب',
        rating: 4,
        avatarColor: Color(0xFFB8AFA0),
      ),
      DoctorResult(
        name: 'علي احمد علي',
        specialty: 'دكتور قلب',
        rating: 3,
        avatarColor: Colors.green,
      ),
      DoctorResult(
        name: 'علي محمد علي',
        specialty: 'دكتور قلب',
        rating: 5,
        avatarColor: Colors.green,
      ),
      DoctorResult(
        name: 'فاروق جويده',
        specialty: 'دكتور عظام',
        rating: 5,
        avatarColor: Color(0xFF8D7A63),
      ),
    ];

    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildSearchField(),
                  const SizedBox(height: 20),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: doctors.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, index) => doctors[index],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomBar(activeTab: BottomTab.search),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        bottom: 24,
      ),
      decoration: const BoxDecoration(
        color: tealColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: const Center(
        child: Text(
          'ابحث عن دكتور',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF0F8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: tealColor),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'البحث',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorResult extends StatelessWidget {
  final String name;
  final String specialty;
  final int rating;
  final Color avatarColor;

  const DoctorResult({
    super.key,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.avatarColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3FF),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Row(
            children: [
              Text(
                '$rating',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.star, color: Colors.amber, size: 18),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: SearchScreen.tealColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                specialty,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(width: 14),
          // صورة الدكتور - استبدلها بـ Image.network / Image.asset لما تجيب الصور الحقيقية
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: avatarColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

enum BottomTab { profile, calendar, search, home }

class AppBottomBar extends StatelessWidget {
  final BottomTab activeTab;

  const AppBottomBar({super.key, required this.activeTab});

  static const Color tealColor = Color(0xFF1FA7A0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            child: Icon(
              Icons.person_outline,
              size: 26,
              color: activeTab == BottomTab.profile ? tealColor : Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppointmentsScreen()),
              );
            },
            child: Icon(
              Icons.calendar_today_outlined,
              size: 24,
              color: activeTab == BottomTab.calendar ? tealColor : Colors.black,
            ),
          ),
          // الزر البارز - بيتحول لأي تاب هو الفعّال حالياً
          if (activeTab == BottomTab.search)
            _buildActivePill('البحث', Icons.search)
          else
            GestureDetector(onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },child: const Icon(Icons.search, size: 26)),
          if (activeTab == BottomTab.home)
            _buildActivePill('الرئيسية', Icons.home_rounded)
          else
            GestureDetector(onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },child: const Icon(Icons.home_outlined, size: 26)),
        ],
      ),
    );
  }

  Widget _buildActivePill(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: tealColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          Icon(icon, color: Colors.white, size: 20),
        ],
      ),
    );
  }
}
