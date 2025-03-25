import 'package:flutter/material.dart';
import 'crop.dart';
import 'crop_list_items.dart';
import 'crop_search_bar.dart';

class FarmFinancialServicesScreen extends StatefulWidget {
  const FarmFinancialServicesScreen({Key? key}) : super(key: key);

  @override
  State<FarmFinancialServicesScreen> createState() => _FarmFinancialServicesScreenState();
}

class _FarmFinancialServicesScreenState extends State<FarmFinancialServicesScreen> {
  final List<Crop> crops = [
    Crop(
      name: 'Organic Corn',
      farmerName: 'John Smith',
      location: 'Iowa Farm',
      pricePerKg: 5.25,
      availableKg: 1000,
      imageUrl: '',
    ),
    Crop(
      name: 'Premium Wheat',
      farmerName: 'Mary Johnson',
      location: 'Kansas Farm',
      pricePerKg: 6.4,
      availableKg: 750,
      imageUrl: '',
    ),
    Crop(
      name: 'Fresh Soybeans',
      farmerName: 'Robert Davis',
      location: 'Illinois Farm',
      pricePerKg: 7.8,
      availableKg: 500,
      imageUrl: '',
    ),
  ];

  final List<String> _tabs = ['Selling Crops', 'Buying Crops', 'Selling Data', 'Market Price'];
  int _selectedTabIndex = 1; // Buying Crops tab selected by default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Farm Financial Services',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _tabs.map((tab) {
                    final isSelected = _tabs.indexOf(tab) == _selectedTabIndex;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTabIndex = _tabs.indexOf(tab);
                          });
                        },
                        child: Text(
                          tab,
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.grey,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              const CropSearchBar(),
              const SizedBox(height: 20),
              const Text(
                'Available Crops',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: crops.length,
                  itemBuilder: (context, index) {
                    return CropListItem(crop: crops[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}