import 'package:flutter/material.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'RH',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 48,
                    letterSpacing: 2.0,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 8), // "Cola" no formulário
                const LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
