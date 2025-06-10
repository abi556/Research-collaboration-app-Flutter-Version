import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  final VoidCallback onBackToLogin;
  const ForgotPasswordScreen({super.key, required this.onBackToLogin});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  String? _feedbackMessage;
  bool _isError = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() {
      _isLoading = true;
      _feedbackMessage = null;
      _isError = false;
    });
    // TODO: Connect to your Riverpod auth provider here
    await Future.delayed(const Duration(seconds: 2)); // Simulate network
    setState(() {
      _isLoading = false;
      _feedbackMessage = 'If an account exists for this email, a reset link has been sent.';
      _isError = false;
      // Uncomment below to show error
      // _feedbackMessage = 'Failed to send reset link.';
      // _isError = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = const Color(0xFFF5F6FA);
    final primaryColor = const Color(0xFF3B82F6);
    final textColor = const Color(0xFF1F2937);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Image.asset(
                      'assets/images/logo.jpg',
                      width: 64,
                      height: 64,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Forgot Password',
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Enter your email address and we will send you a link to reset your password.',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                    style: GoogleFonts.inter(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : Text(
                              'Send Reset Link',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  if (_feedbackMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      _feedbackMessage!,
                      style: GoogleFonts.inter(
                        color: _isError ? Colors.red : Colors.green,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: widget.onBackToLogin,
                    child: Text(
                      'Back to Login',
                      style: GoogleFonts.inter(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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