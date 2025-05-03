// --- screens/forgot_password_screen.dart ---
// UI for the Forgot Password Screen.

import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetLink() {
    if (_formKey.currentState!.validate()) {
      // need to make backend to send real email. 
      print('Sending reset link to: ${_emailController.text}');

      // show confirm - snacKbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset link sent (if account exists).'),
          backgroundColor: Colors.green,
        ),
      );
      // login back after delay feature - gotta see again
      Navigator.pop(context); 
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
       appBar: AppBar(
        title: const Text('Forgot Password'),
         leading: IconButton( // Add back button
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: theme.colorScheme.primaryContainer,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.lock_reset_outlined,
                    size: 60,
                    color: theme.colorScheme.primary,
                  ),
                   const SizedBox(height: 16),
                   Text(
                    'Reset Password',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Enter your email address below and we'll send you a link to reset your password.",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Send Button
                  ElevatedButton(
                    onPressed: _sendResetLink,
                    child: const Text('Send Reset Link'),
                  ),
                   const SizedBox(height: 16),
                   // some extra info here _ gotta look at it later 
                   // Back to Login Link (already handled by AppBar back button)
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.pop(context); // Go back
                  //   },
                  //   child: Text(
                  //     'Back to log in',
                  //     style: TextStyle(color: theme.colorScheme.primary),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

