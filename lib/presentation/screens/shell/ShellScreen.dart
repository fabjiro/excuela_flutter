import 'package:excuela_flutter/presentation/screens/card/CardScreen.dart';
import 'package:excuela_flutter/presentation/screens/home/ProgressScreen.dart';
import 'package:excuela_flutter/presentation/screens/quiz/QuizScreen.dart';
import 'package:excuela_flutter/presentation/widgets/customNavigationBar/CustomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          ProgressScreen(),
          CardScreen(),
          QuizScreen(),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        children: const [
          NavigationOption(
            icon: Iconsax.home,
            title: 'Progreso',
          ),
          NavigationOption(
            icon: Iconsax.map,
            title: 'Tarjeta',
          ),
          NavigationOption(
            icon: Iconsax.map,
            title: 'Quiz',
          )
        ],
        onChange: (int val) => _pageController.jumpToPage(val),
      ),
    );
  }
}
