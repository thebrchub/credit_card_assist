import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _slides = [
    {
      'title': 'Track Smarter',
      'subtitle': 'Manage expenses with ease and clarity.',
      'image': 'assets/onboard1.png',
    },
    {
      'title': 'Maximize Benefits',
      'subtitle': 'Know which card gives the best offer.',
      'image': 'assets/onboard2.png',
    },
    {
      'title': 'Peace of Mind',
      'subtitle': 'Never miss expiry dates or offers again.',
      'image': 'assets/onboard3.png',
    },
  ];

  void _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/welcome');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF0E0F1B),
      body: SafeArea(
        child: Stack(
          children: [
            // Fullscreen Image Slider
            PageView.builder(
              controller: _pageController,
              itemCount: _slides.length,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemBuilder: (_, index) {
                final slide = _slides[index];
                return Container(
                  width: size.width,
                  height: size.height,
                  padding: const EdgeInsets.all(24),
                  color: const Color(0xFF0E0F1B),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(
                          slide['image']!,
                          width: size.width * 0.85,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        slide['title']!,
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        slide['subtitle']!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                );
              },
            ),

            // Dots & Buttons
            Column(
              children: [
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_slides.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentIndex == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentIndex < _slides.length - 1)
                        TextButton(
                          onPressed: _completeOnboarding,
                          child: const Text("Skip", style: TextStyle(color: Colors.white70)),
                        ),
                      ElevatedButton(
                        onPressed: () {
                          if (_currentIndex == _slides.length - 1) {
                            _completeOnboarding();
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          _currentIndex == _slides.length - 1 ? "Get Started" : "Next",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
