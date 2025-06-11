import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';

enum UserRole { student, professor, admin }

class LoginScreen extends ConsumerStatefulWidget {
  final VoidCallback onSignUp;
  final VoidCallback onForgotPassword;
  final void Function(String role) onLoginSuccess;
  const LoginScreen({
    super.key,
    required this.onSignUp,
    required this.onForgotPassword,
    required this.onLoginSuccess,
  });

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserRole _selectedRole = UserRole.student;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    ref.read(authProvider.notifier).login(
      _emailController.text,
      _passwordController.text,
      _selectedRole.name.toUpperCase(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      next.maybeWhen(
        authenticated: (user) {
          widget.onLoginSuccess(user.role);
        },
        error: (message) {
          String displayMessage;
          if (message is List) {
            displayMessage = (message as List).join('\n');
          } else {
            displayMessage = message.toString();
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(displayMessage)),
          );
        },
        orElse: () {},
      );
    });
    final authState = ref.watch(authProvider);
    final backgroundColor = const Color(0xFFF5F6FA);
    final primaryColor = const Color(0xFF3B82F6);
    final textColor = const Color(0xFF1F2937);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
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
                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(
                    'Collabrix',
                    style: const TextStyle(
                      fontFamily: 'Orbitron',
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ),
                // Login/Signup toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(foregroundColor: primaryColor),
                      child: Text(
                        'Login',
                        style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text('|', style: GoogleFonts.inter(color: Colors.grey, fontSize: 20)),
                    TextButton(
                      onPressed: widget.onSignUp,
                      style: TextButton.styleFrom(foregroundColor: Colors.grey),
                      child: Text('Sign Up', style: GoogleFonts.inter(fontSize: 20)),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Email field
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
                const SizedBox(height: 16),
                // Password field
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  style: GoogleFonts.inter(),
                ),
                const SizedBox(height: 24),
                // Login as section
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login as:',
                    style: GoogleFonts.inter(fontSize: 16, color: textColor),
                  ),
                ),
                const SizedBox(height: 8),
                // Role selection
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: UserRole.values.map((role) {
                    final isSelected = _selectedRole == role;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(
                            role.name[0].toUpperCase() + role.name.substring(1),
                            style: GoogleFonts.inter(fontSize: 14),
                          ),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() => _selectedRole = role);
                          },
                          selectedColor: primaryColor,
                          backgroundColor: Colors.grey[200],
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : textColor,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: widget.onForgotPassword,
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.inter(color: primaryColor),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Login button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 