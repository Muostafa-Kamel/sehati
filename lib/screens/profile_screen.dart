import 'package:flutter/material.dart';
import 'package:sehati/screens/appointments_screen.dart';
import 'package:sehati/screens/homepage.dart';
import 'package:sehati/screens/search_screeen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color tealColor = Color(0xFF1FA7A0);

  // بيانات المستخدم - استبدلها بالداتا الجاية من الـ API
  final String name = 'سيد عبدالعزيز';
  final String bio = 'لم تضاف';
  final String email = 'sayed22@gmail.com';
  final String phone = 'لم تضاف';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  _buildNameAndAvatar(),
                  const SizedBox(height: 32),
                  _buildBioSection(),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 16),
                  _buildContactSection(),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 16),
                  _buildBookingsSection(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomBar(activeTab: BottomTab.profile),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        bottom: 24,
        right: 20,
        left: 20,
      ),
      decoration: const BoxDecoration(
        color: tealColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.settings_outlined, color: Colors.white, size: 26),
          Expanded(
            child: Center(
              child: Text(
                'الحساب الشخصي',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          // مساحة فاضية عشان العنوان يفضل في النص تماماً زي التصميم
          const SizedBox(width: 26),
        ],
      ),
    );
  }

  Widget _buildNameAndAvatar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // صورة المستخدم مع زر الكاميرا
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: tealColor,
                shape: BoxShape.circle,
              ),
              // استبدلها بـ Image.network(user.avatarUrl) لو موجودة صورة حقيقية
              child: const Icon(
                Icons.medical_services_outlined,
                color: Colors.white,
                size: 50,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: GestureDetector(
                onTap: () {
                  // TODO: افتح اختيار صورة من المعرض أو الكاميرا
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: tealColor,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // TODO: انتقل لشاشة تعديل الحساب
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: tealColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: const Text(
                'تعديل الحساب',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBioSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'نبذه تعريفيه',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Text(
          bio,
          style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'معلومات التواصل',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF0F8),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              _buildContactRow(email, Icons.email_outlined),
              const SizedBox(height: 16),
              _buildContactRow(phone, Icons.phone_outlined),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactRow(String value, IconData icon) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: tealColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const Spacer(),
        Text(value, style: const TextStyle(fontSize: 15)),
      ],
    );
  }

  Widget _buildBookingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'حجزاتي',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        // لو مفيش حجوزات ممكن تظهر رسالة، أو تعرض ليست من AppointmentCard
        // زي الشاشة اللي عملناها قبل كده
        Text(
          'لا يوجد حجوزات حالياً',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
        ),
      ],
    );
  }
}

enum BottomTab { profile, appointments, search, home }

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
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (activeTab == BottomTab.profile)
            _buildActivePill('الحساب', Icons.person)
          else
            GestureDetector(onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },child: const Icon(Icons.person_outline, size: 26)),
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppointmentsScreen()),
              );
            },
            child: Icon(
              Icons.calendar_today_outlined,
              size: 24,
              color: activeTab == BottomTab.appointments ? tealColor : Colors.black,
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
            child: Icon(
              Icons.search,
              size: 26,
              color: activeTab == BottomTab.search ? tealColor : Colors.black,
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Icon(
              Icons.home_outlined,
              size: 26,
              color: activeTab == BottomTab.home ? tealColor : Colors.black,
            ),
          ),
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