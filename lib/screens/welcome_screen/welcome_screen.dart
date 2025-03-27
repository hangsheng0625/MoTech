import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth_button.dart';
import '../../theme/app_colors.dart';
import '../login_screen/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width <= 640;
    final isMediumScreen = screenSize.width <= 991;

    return Scaffold(
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
          child: Column(
            children: [
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 406),
                  child: Column(
                    children: [
                      const SizedBox(height: 4),
                      Image.asset(
                        'assets/screen/logo.png', // Updated path
                        width: 74,
                        height: 74,
                      ),
                      const SizedBox(height: 4),
                      Stack(
                        // Align both texts exactly on top of each other
                        alignment: Alignment.center,
                        children: [
                          Text(
                            'MoTech',
                            style: GoogleFonts.lobster(
                              fontSize: 100,
                              color: const Color.fromARGB(255, 30, 129, 15), // main fill color
                              // Add a drop shadow for a “3D” look
                              shadows: [
                                const Shadow(
                                  offset: Offset(2, 2),  // how far the shadow is
                                  blurRadius: 6,               // how soft the shadow is
                                  color: Color.fromARGB(95, 255, 254, 254),       // shadow color
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Image.asset(
                        'assets/screen/welcome-page-center-image.png', // Updated path
                        width: isSmallScreen ? 250 : (isMediumScreen ? 275 : 346),
                        height: isSmallScreen ? 250 : (isMediumScreen ? 275 : 346),
                      ),
                      const SizedBox(height: 25),
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
                          vertical: isSmallScreen ? 50 : 74,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Get Started',
                              style: GoogleFonts.montserrat(
                                fontSize: isSmallScreen ? 35 : 45,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Farming Smarter, Not Harder',
                              style: GoogleFonts.montserrat(
                                fontSize: isSmallScreen ? 18 : 20,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 40),
                            isSmallScreen
                                ? Column(
                                    children: [
                                      AuthButton(
                                        text: 'Start Journey',
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const LoginScreen()
                                            ),
                                          );
                                        },
                                      ),
  
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AuthButton(
                                        text: 'Start Journey',
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const LoginScreen()
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                          ],
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
    );
  }
}