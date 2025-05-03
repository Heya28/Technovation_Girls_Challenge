
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/home_screen.dart'; // main navigation
import 'theme/app_theme.dart'; 
void main() {
  runApp(const ArfidHelpApp());
}

class ArfidHelpApp extends StatelessWidget {
  const ArfidHelpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ARFID Help',
      theme: AppTheme.lightTheme, // using defined theme
      // defining initial and other routes
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/home': (context) => const HomeScreen(),
        // others maybe screenss
      },
      // removing debug manner
      debugShowCheckedModeBanner: false,
    );
  }
}



// --- pubspec.yaml (Dependencies) ---
/*
dependencies:
  flutter:
    sdk: flutter

  # Addcupertino icons if not already present
  cupertino_icons: ^1.0.2
  # Optional: Add packages for state management (provider, riverpod),
  # HTTP requests (http, dio), local storage (shared_preferences), etc.
  # google_fonts: ^6.1.0 # Example if using Google Fonts

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0 # Or latest version

flutter:
  uses-material-design: true

  # Optional: Add assets like images or fonts here
  # assets:
  #   - images/logo.png

  # fonts:
  #   - family: Roboto
  #     fonts:
  #       - asset: fonts/Roboto-Regular.ttf
  #       - asset: fonts/Roboto-Bold.ttf
  #         weight: 700
*/

