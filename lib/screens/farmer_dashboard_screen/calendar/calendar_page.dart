import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/components/navbar.dart';
import '../earning/total_earning_screen.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  int currentMonth = 3;
  int currentYear = 2024;

  // Expanded dummy data for day details
  final Map<int, DayDetails> dayDetails = {
    21: DayDetails(
      temperature: 28.5,
      soilMoisture: 65.3,
      soilPH: 6.8,
      soilNitrogen: 45.2,
      cropHealth: 'Healthy',
      earnings: 250.0,
      waterNeed: 'Low',
      weatherCondition: 'Sunny',
    ),
    22: DayDetails(
      temperature: 26.7,
      soilMoisture: 42.1,
      soilPH: 6.5,
      soilNitrogen: 38.9,
      cropHealth: 'Needs Water',
      earnings: 180.0,
      waterNeed: 'High',
      weatherCondition: 'Partly Cloudy',
    ),
    23: DayDetails(
      temperature: 27.3,
      soilMoisture: 40.5,
      soilPH: 6.6,
      soilNitrogen: 40.1,
      cropHealth: 'Needs Water',
      earnings: 180.0,
      waterNeed: 'High',
      weatherCondition: 'Cloudy',
    ),
    24: DayDetails(
      temperature: 29.1,
      soilMoisture: 55.7,
      soilPH: 7.0,
      soilNitrogen: 42.6,
      cropHealth: 'Mixed',
      earnings: 320.0,
      waterNeed: 'Medium',
      weatherCondition: 'Sunny',
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFCD8), Color(0xFFCBEFD1)],
            stops: [0.196, 0.451],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildHeader(),
                  _buildDaysOfWeek(),
                  Expanded(
                    child: _buildCalendarGrid(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(index: 1),
    );
  }

  Widget _buildHeader() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Text(
            'Calendar',
            style: GoogleFonts.inter(
              fontSize: isSmallScreen ? 18 : 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          
          const Spacer(),
          
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _NavigationButton(
                icon: Icons.chevron_left,
                onPressed: _goToPreviousMonth,
              ),
              
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 4 : 12,
                ),
                child: Text(
                  '${_getMonthName(currentMonth)} $currentYear',
                  style: GoogleFonts.inter(
                    fontSize: isSmallScreen ? 14 : 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF334155),
                  ),
                ),
              ),
              
              _NavigationButton(
                icon: Icons.chevron_right,
                onPressed: _goToNextMonth,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDaysOfWeek() {
    final daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final isSmallScreen = MediaQuery.of(context).size.width < 360;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: daysOfWeek
            .map(
              (day) => Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: GoogleFonts.inter(
                      fontSize: isSmallScreen ? 12 : 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF334155),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final daysInMonth = _getDaysInMonth(currentYear, currentMonth);
    final firstWeekday = DateTime(currentYear, currentMonth, 1).weekday; 
    final leadingBlanks = (firstWeekday % 7);

    final cells = <Widget>[];

    for (int i = 0; i < leadingBlanks; i++) {
      cells.add(const SizedBox());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final extraInfo = dayDetails[day];
      cells.add(CalendarCell(
        day: day,
        extraText: extraInfo?.cropHealth,
        onTap: extraInfo != null 
          ? () => _showDayDetails(day, extraInfo) 
          : null,
      ));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.7,
        children: cells,
      ),
    );
  }

  void _showDayDetails(int day, DayDetails details) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DayDetailsBottomSheet(
        day: day,
        month: _getMonthName(currentMonth),
        year: currentYear,
        details: details,
      ),
    );
  }

  void _goToPreviousMonth() {
    setState(() {
      currentMonth--;
      if (currentMonth < 1) {
        currentMonth = 12;
        currentYear--;
      }
    });
  }

  void _goToNextMonth() {
    setState(() {
      currentMonth++;
      if (currentMonth > 12) {
        currentMonth = 1;
        currentYear++;
      }
    });
  }

  String _getMonthName(int month) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June', 
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return monthNames[month - 1];
  }

  int _getDaysInMonth(int year, int month) {
    final firstOfNextMonth = (month == 12)
        ? DateTime(year + 1, 1, 1)
        : DateTime(year, month + 1, 1);
    final lastDayCurrentMonth =
        firstOfNextMonth.subtract(const Duration(days: 1)).day;
    return lastDayCurrentMonth;
  }
}

class _NavigationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _NavigationButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 360;
    
    return Container(
      width: isSmallScreen ? 32 : 40,
      height: isSmallScreen ? 32 : 40,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Center(
            child: Icon(
              icon,
              color: Colors.black,
              size: isSmallScreen ? 20 : 24,
            ),
          ),
        ),
      ),
    );
  }
}

class CalendarCell extends StatelessWidget {
  final int day;
  final String? extraText;
  final VoidCallback? onTap;

  const CalendarCell({
    Key? key,
    required this.day,
    this.extraText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width <= 640;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: onTap != null 
            ? const Color(0xFFDCE1E6) 
            : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: _buildDayContent(isSmallScreen),
      ),
    );
  }

  Widget _buildDayContent(bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$day',
          style: GoogleFonts.inter(
            fontSize: isSmallScreen ? 12 : 14,
            color: const Color(0xFF334155),
          ),
        ),
        if (extraText != null)
          Expanded(
            child: Center(
              child: Text(
                extraText!,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: isSmallScreen ? 10 : 12,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class DayDetails {
  final double temperature;
  final double soilMoisture;
  final double soilPH;
  final double soilNitrogen;
  final String cropHealth;
  final double earnings;
  final String waterNeed;
  final String weatherCondition;

  DayDetails({
    required this.temperature,
    required this.soilMoisture,
    required this.soilPH,
    required this.soilNitrogen,
    required this.cropHealth,
    required this.earnings,
    required this.waterNeed,
    required this.weatherCondition,
  });
}

class DayDetailsBottomSheet extends StatelessWidget {
  final int day;
  final String month;
  final int year;
  final DayDetails details;

  const DayDetailsBottomSheet({
    Key? key,
    required this.day,
    required this.month,
    required this.year,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: ListView(
          controller: controller,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '$month $day, $year',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            _buildDataSection(
              title: 'Weather Information',
              children: [
                _buildDataRow('Temperature', '${details.temperature}°C'),
                _buildDataRow('Weather', details.weatherCondition),
              ],
            ),

            _buildDataSection(
              title: 'Soil Conditions',
              children: [
                _buildDataRow('Moisture', '${details.soilMoisture}%'),
                _buildDataRow('pH Level', details.soilPH.toStringAsFixed(1)),
                _buildDataRow('Nitrogen', '${details.soilNitrogen} ppm'),
                _buildDataRow('Water Need', details.waterNeed),
              ],
            ),

            _buildDataSection(
              title: 'Crop Health',
              children: [
                _buildDataRow('Status', details.cropHealth),
              ],
            ),

            _buildDataSection(
              title: 'Earnings',
              children: [
                _buildDataRow('Total Earnings', '\RM${details.earnings}'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TotalEarningScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4B9B28),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'View',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF4B9B28),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        ...children,
        const Divider(height: 1, color: Colors.grey),
      ],
    );
  }
}