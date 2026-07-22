import 'package:flutter/material.dart';
import 'package:sehati/screens/homepage.dart';
import 'package:sehati/screens/profile_screen.dart';
import 'package:sehati/screens/search_screeen.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  static const Color tealColor = Color(0xFF1FA7A0);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  // بيانات الحجز - استبدلها بالداتا الجاية من الـ API
  final List<AppointmentModel> _appointments = [
    AppointmentModel(
      doctorName: 'د. خالد علي عبدالله',
      date: '٢٧ أبريل ٢٠٢٦',
      time: '٣:٠٠ م',
      patientName: 'fghgfh',
      city: 'مدينه نصر القاهره',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: _appointments
                    .map(
                      (appointment) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: AppointmentCard(
                          appointment: appointment,
                          onDelete: () => _deleteAppointment(appointment),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomBar(
        activeTab: BottomTab.appointments,
      ),
    );
  }

  void _deleteAppointment(AppointmentModel appointment) {
    // هنا بتنادي الـ API بتاع حذف الحجز، وبعد نجاحه تشيله من الليست
    setState(() {
      _appointments.remove(appointment);
    });
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        bottom: 24,
      ),
      decoration: const BoxDecoration(
        color: AppointmentsScreen.tealColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: const Center(
        child: Text(
          'مواعيد الحجز',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class AppointmentModel {
  final String doctorName;
  final String date;
  final String time;
  final String patientName;
  final String city;

  AppointmentModel({
    required this.doctorName,
    required this.date,
    required this.time,
    required this.patientName,
    required this.city,
  });
}

class AppointmentCard extends StatefulWidget {
  final AppointmentModel appointment;
  final VoidCallback onDelete;

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.onDelete,
  });

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    final appointment = widget.appointment;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF0F8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              // زر الطي/الفتح
              GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 26,
                ),
              ),
              const Spacer(),
              Text(
                appointment.doctorName,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  color: AppointmentsScreen.tealColor,
                ),
              ),
            ],
          ),
          if (_expanded) ...[
            const SizedBox(height: 14),
            _buildInfoRow(appointment.date, Icons.calendar_today_outlined),
            const SizedBox(height: 10),
            _buildInfoRow(appointment.time, Icons.access_time),
            const SizedBox(height: 18),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'اسم المريض: ${appointment.patientName}',
                style: const TextStyle(fontSize: 15),
              ),
            ),
            const SizedBox(height: 10),
            _buildInfoRow(appointment.city, Icons.location_on_outlined),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _confirmDelete(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF44667),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'حذف الحجز',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String text, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(text, style: const TextStyle(fontSize: 15)),
        const SizedBox(width: 8),
        Icon(icon, size: 18, color: AppointmentsScreen.tealColor),
      ],
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('تأكيد الحذف'),
        content: const Text('هل أنت متأكد من حذف هذا الحجز؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              widget.onDelete();
            },
            child: const Text(
              'حذف',
              style: TextStyle(color: Color(0xFFF44667)),
            ),
          ),
        ],
      ),
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
            onTap: () {
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
          if (activeTab == BottomTab.appointments)
            _buildActivePill('المواعيد', Icons.calendar_today_outlined)
          else
            GestureDetector(onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppointmentsScreen()),
              );
            },child: const Icon(Icons.calendar_today_outlined, size: 24)),
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
