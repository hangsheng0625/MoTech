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
          child: Column(
            children: [
              // Custom Tab Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {

                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4B9B28),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'Total Earning',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                        },
                      ),
                    ),
                  ],
                ),
              ),
              
              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width > 991 ? 32 : 16,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      FinancialAnalysisCard(),
                      const SizedBox(height: 24),
                      // const CropSourcesCard(),
                      const SizedBox(height: 24),
                      const LoanCards(),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: MediaQuery.of(context).size.width > 640 ? 190 : double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CalendarPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4B9B28),
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Save to Calendar',
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
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(index: 1),
    );
  }
}