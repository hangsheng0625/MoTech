import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/components/navbar.dart';
import 'financial_analysis_card.dart';
import 'loan_card.dart';
import '../calendar/calendar_page.dart';

class TotalLoanScreen extends StatefulWidget {
  const TotalLoanScreen({Key? key}) : super(key: key);

  @override
  _TotalLoanScreenState createState() => _TotalLoanScreenState();
}

class _TotalLoanScreenState extends State<TotalLoanScreen> {
  // Button styling constants
  final _buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF4B9B28),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 640;
    final horizontalPadding = MediaQuery.of(context).size.width > 991 ? 32.0 : 16.0;

    return Scaffold(
      body: Container(
        decoration: _buildBackgroundDecoration(),
        child: SafeArea(
          child: Column(
            children: [
              _buildMainContent(isWideScreen, horizontalPadding),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(index: 1),
    );
  }

  BoxDecoration _buildBackgroundDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFFCD8), Color(0xFFCBEFD1)],
        stops: [0.196, 0.451],
      ),
    );
  }

  Widget _buildMainContent(bool isWideScreen, double horizontalPadding) {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 16,
        ),
        child: Column(
          children: [
            FinancialAnalysisCard(),
            const SizedBox(height: 24),
            const SpendingCards(),
            const SizedBox(height: 24),
            _buildSaveToCalendarButton(isWideScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveToCalendarButton(bool isWideScreen) {
    return SizedBox(
      width: isWideScreen ? 190 : double.infinity,
      child: ElevatedButton(
        style: _buttonStyle,
        onPressed: () => _navigateToCalendarScreen(),
        child: Text(
          'Save to Calendar',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _navigateToCalendarScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CalendarPage()),
    );
  }
}