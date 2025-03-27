import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../homescreen/home_screen.dart';
import 'package:myapp/components/navbar.dart';
import '../../theme/app_colors.dart';

class FruitMultiSelectScreen extends StatefulWidget {
  const FruitMultiSelectScreen({Key? key}) : super(key: key);

  @override
  _FruitMultiSelectScreenState createState() => _FruitMultiSelectScreenState();
}

class _FruitMultiSelectScreenState extends State<FruitMultiSelectScreen> {
  final List<String> fruits = [
    'Durian', 'Rambutan', 'Mango', 'Grape', 'Coconut', 'Pineapple', 
    'Banana', 'Apple', 'Orange', 'Papaya',
  ];

  List<String> selectedFruits = [];
  List<String> filteredFruits = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredFruits = fruits;
  }

  void _filterFruits(String query) {
    setState(() {
      filteredFruits = fruits
          .where((fruit) => fruit.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _submitFruits() {
    if (selectedFruits.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // Optional: Show a snackbar if no fruits are selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select at least one fruit',
            style: GoogleFonts.montserrat(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width <= 640;
    final isMediumScreen = screenSize.width <= 991;

    return Scaffold(
      bottomNavigationBar: const Navbar(index: 1),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.196, 0.451],
            colors: [
              AppColors.gradientStart,
              AppColors.gradientEnd,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 406),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Text(
                    'Select your fruits',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 45,
                      fontWeight: FontWeight.w900,
                      color: const Color.fromARGB(255, 49, 129, 5),
                      shadows: [
                        const Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 6,
                          color: Color.fromARGB(95, 255, 254, 254),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: isSmallScreen ? 30 : 50,
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${selectedFruits.length} Fruits Selected',
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromARGB(255, 30, 129, 15),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Search Input Field
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search Fruits',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                            onChanged: _filterFruits,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 400, // Fixed height for scrollable list
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: filteredFruits.length,
                            itemBuilder: (context, index) {
                              final fruit = filteredFruits[index];
                              return CheckboxListTile(
                                title: Text(
                                  fruit,
                                  style: GoogleFonts.montserrat(
                                    color: const Color.fromARGB(255, 30, 129, 15),
                                  ),
                                ),
                                value: selectedFruits.contains(fruit),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedFruits.add(fruit);
                                    } else {
                                      selectedFruits.remove(fruit);
                                    }
                                  });
                                },
                                controlAffinity: ListTileControlAffinity.leading,
                                activeColor: const Color.fromARGB(255, 30, 129, 15),
                                checkColor: Colors.white,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _submitFruits,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 30, 129, 15),
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Submit',
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}