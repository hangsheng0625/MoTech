import 'package:flutter/material.dart';
import 'package:myapp/components/navbar.dart';
import 'content_card.dart';
import 'community_screen.dart';
import '../../theme/app_colors.dart';

enum TabItem { tutorialVideos, community, equipments }

class FarmingSupportScreen extends StatefulWidget {
  const FarmingSupportScreen({Key? key}) : super(key: key);

  @override
  _FarmingSupportScreenState createState() => _FarmingSupportScreenState();
}

class _FarmingSupportScreenState extends State<FarmingSupportScreen> {
  TabItem _selectedTab = TabItem.tutorialVideos;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 640;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.196, 0.451],
            colors: [
              Color(0xFFFFFCD8), // Light yellow
              Color(0xFFCBEFD1), // Light green
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar-like title
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Farming Support Hub',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
              ),

              // Navigation Section
              _buildNavigation(),
              
              const SizedBox(height: 16),
              
              // Divider
              Container(
                height: 1,
                color: Colors.black26,
              ),
              
              const SizedBox(height: 24),
              
              // Content Section
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.0 : 24.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: _buildContent(),
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

  Widget _buildNavigation() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavItem('Tutorial Videos', TabItem.tutorialVideos),
          const SizedBox(width: 48),
          _buildNavItem('Community', TabItem.community),
          const SizedBox(width: 48),
          _buildNavItem('Equipments', TabItem.equipments),
        ],
      ),
    );
  }

  Widget _buildNavItem(String text, TabItem tab) {
    final isSelected = _selectedTab == tab;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = tab),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.blue : AppColors.textPrimary,
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          height: 1.615,
          decoration: isSelected ? TextDecoration.underline : null,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedTab) {
      case TabItem.tutorialVideos:
        return _buildTutorialContent();
      case TabItem.community:
        return const CommunityScreen(); // Use the new CommunityScreen widget
      case TabItem.equipments:
        return _buildEquipmentContent();
    }
  }

  Widget _buildTutorialContent() {
    return ListView(
      shrinkWrap: true,
      children: const [
        ContentCard(
          title: 'Durian Musang King',
          description: 'Unlock expert techniques for nurturing and harvesting premium Durian Musang King. Elevate your orchard’s yield with proven care strategies.',
          showIcon: false,
          imagePath: 'assets/images/durian-musang-king.jpg', // Add image
        ),
        SizedBox(height: 24),
        ContentCard(
          title: 'Coconut Farming',
          description: 'Explore our comprehensive guide to modern coconut farming with step-by-step instructions for efficient irrigation and eco-friendly practices.',
          showIcon: false,
          imagePath: 'assets/images/coconut.jpg',
        ),
      ],
    );
  }

  Widget _buildEquipmentContent() {
    return ListView(
      shrinkWrap: true,
      children: const [
        ContentCard(
          title: 'Equipment Rentals',
          description: 'Find nearby agricultural machinery rentals',
          showIcon: false,
          imagePath: 'assets/images/rental.png',
        ),
        SizedBox(height: 24),
        ContentCard(
          title: 'Tool Suppliers',
          description: 'Verified suppliers in your area',
          showIcon: false,
          imagePath: 'assets/images/tools.jpg',
        ),
      ],
    );
  }
}