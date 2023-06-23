import 'package:flutter/material.dart';

import '../../screens/home_screen/home_screen.dart';

class SplashScreen extends StatelessWidget {
  static const routName = "/splashscreen";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScreen();

    // Scaffold(
    //   backgroundColor: Colors.white,
    //   body: Center(
    //     child: Stack(
    //       children: const [
    //         Align(alignment: Alignment.center, child: Text("Splash Screen")),
    //       ],
    //     ),
    //   ),
    // );
  }
}
