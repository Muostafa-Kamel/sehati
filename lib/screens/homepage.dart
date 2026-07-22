import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sehati/core/app_colors.dart';
import 'package:sehati/core/widgets/top_bar.dart';

import '../core/widgets/app_bottom_bar.dart';
import '../core/widgets/doctor_rating_card.dart';
import '../core/widgets/specialty_card.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     final user = FirebaseAuth.instance.currentUser;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home"),
//         centerTitle: true,
//       ),
//
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//
//               const Icon(
//                 Icons.verified_user,
//                 color: Colors.green,
//                 size: 120,
//               ),
//
//               const SizedBox(height: 20),
//
//               const Text(
//                 "Logged In",
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               Text(
//                 user?.email ?? "",
//                 style: const TextStyle(fontSize: 18),
//               ),
//
//               const SizedBox(height: 40),
//
//               SizedBox(
//                 width: double.infinity,
//                 height: 55,
//                 child: ElevatedButton(
//                   onPressed: () async {
//
//                     await FirebaseAuth.instance.signOut();
//
//                   },
//                   child: const Text(
//                     "Logout",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 8),
              TopBar.buildTopBar(),
              const SizedBox(height: 24),
              _buildWelcomeText(),
              const SizedBox(height: 12),
              _buildHeadline(),
              const SizedBox(height: 24),
              _buildSearchBar(),
              const SizedBox(height: 28),
              _buildSectionTitle('التخصصات'),
              const SizedBox(height: 14),
              _buildSpecialtiesList(),
              const SizedBox(height: 28),
              _buildSectionTitle('الأعلى تقييماً'),
              const SizedBox(height: 14),
              const DoctorRatingCard(
                name: 'علي محمد علي',
                specialty: 'دكتور قلب',
                rating: 5,
                avatarColor: Colors.green,
              ),
              const SizedBox(height: 14),
              const DoctorRatingCard(
                name: 'فاروق جويده',
                specialty: 'جراحة عامة',
                rating: 5,
                avatarColor: Colors.brown,
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomBar(),
    );
  }



  Widget _buildWelcomeText() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(fontSize: 16, color: Colors.black87),
        children: [
          TextSpan(text: 'مرحباً، '),
          TextSpan(
            text: 'سيد عبدالعزيز',
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ],
      ),
      textDirection: .ltr,
    );
  }

  Widget _buildHeadline() {
    return const Text(
      'احجز الآن وكن جزءًا من رحلتك الصحية.',
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        height: 1.4,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F6FB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  'ابحث عن دكتور',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(4),
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildSpecialtiesList() {
    final specialties = [
      _Specialty('تحاليل طبية', const Color(0xFFFF8A65)),
      _Specialty('دكتور قلب', const Color(0xFF3BC9A8)),
      _Specialty('جراحة عامة', const Color(0xFF4C9EF7)),
    ];

    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        // بما إن التطبيق RTL، الليست هتبدأ من اليمين تلقائياً
        itemCount: specialties.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final item = specialties[index];
          return SpecialtyCard(title: item.title, color: item.color);
        },
      ),
    );
  }
}

class _Specialty {
  final String title;
  final Color color;
  _Specialty(this.title, this.color);
}





