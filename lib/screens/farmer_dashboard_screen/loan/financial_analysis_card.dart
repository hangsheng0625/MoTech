import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class FinancialAnalysisCard extends StatelessWidget {
  FinancialAnalysisCard({Key? key}) : super(key: key) {
    // Initialize random data when the widget is created
    _generateRandomData();
  }

  final List<PieChartSectionData> _pieData = [];
  final _random = math.Random();
  final List<Color> _colors = [
    const Color(0xFF4318D1),
    const Color(0xFFFFB800),
    const Color(0xFF00B37E),
    const Color(0xFFFF6B6B),
  ];
  final List<String> _labels = ['Mr Tan', 'Maybank', 'Public Bank', 'Mr Chua'];

  void _generateRandomData() {
    _pieData.clear();
    
    // Generate random values that sum up to 100
    final values = List.generate(4, (index) => _random.nextDouble() * 100);
    final total = values.reduce((a, b) => a + b);
    
    for (int i = 0; i < 4; i++) {
      final value = (values[i] / total * 100).roundToDouble();
      _pieData.add(
        PieChartSectionData(
          color: _colors[i],
          value: value,
          title: '${value.toStringAsFixed(1)}%',
          radius: 100,
          titleStyle: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final isMediumScreen = screenWidth > 640;

    return Container(
      padding: EdgeInsets.all(screenWidth > 991 ? 24 : 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFF6),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          // _buildHeaderText(isMediumScreen),
          const SizedBox(height: 24),
          _buildPieChart(),
          const SizedBox(height: 16),
          _buildLegend(),
          const SizedBox(height: 24),
          _buildPeriodSelector(),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
          sections: _pieData,
          centerSpaceRadius: 40,
          sectionsSpace: 4,
          startDegreeOffset: -90,
          borderData: FlBorderData(show: false),
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              // Handle touch events if needed
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      children: List.generate(4, (index) => _buildLegendItem(index)),
    );
  }

  Widget _buildLegendItem(int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: _colors[index],
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          _labels[index],
          style: GoogleFonts.inter(
            color: const Color(0xFF334155),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // Keep the existing header and period selector methods
  // Widget _buildHeaderText(bool isMediumScreen) {
  //   return Text(
  //     'Crop Financial Analysis',
  //     style: GoogleFonts.inter(
  //       fontSize: isMediumScreen ? 20 : 18,
  //       fontWeight: FontWeight.w700,
  //       color: const Color(0xFF334155),
  //     ),
  //     textAlign: TextAlign.left,
  //   );
  // }

  Widget _buildPeriodSelector() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFDCE1E6),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(4),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PeriodButton(label: 'Month', isSelected: true),
          SizedBox(width: 4),
          _PeriodButton(label: 'Year', isSelected: false),
        ],
      ),
    );
  }
}

class _PeriodButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _PeriodButton({
    required this.label,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 80),
      child: Material(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () {
            // Add your tap logic here
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            alignment: Alignment.center,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF334155),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
