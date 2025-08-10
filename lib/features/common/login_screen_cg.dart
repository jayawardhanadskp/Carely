// ignore_for_file: deprecated_member_use

import 'package:carely/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  final AuthService _authService = AuthService();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final userCredential = await _authService.signInWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );

        final uid = userCredential?.user?.uid;
        if (uid == null) throw Exception('Authentication failed. No user ID.');

        final firestore = FirebaseFirestore.instance;
        final caregiverDoc =
            await firestore.collection('caregivers').doc(uid).get();
        final seekerDoc = await firestore.collection('seekers').doc(uid).get();

        if (caregiverDoc.exists) {
          Navigator.pushReplacementNamed(context, '/caregiver/main');
        } else if (seekerDoc.exists) {
          Navigator.pushReplacementNamed(context, '/seeker/main');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No matching user profile found.')),
          );
        }
      } on FirebaseAuthException catch (e) {
        String message = 'Login failed. Please try again.';
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Incorrect password.';
        }
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An unexpected error occurred.')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showUserTypeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Define colors here or use your custom color file
        const Color primaryBlue = Color(0xFF2563EB);
        const Color primaryGreen = Color(0xFF16A34A);
        const Color lightBlue = Color(0xFFE0F2FE); // For the caregiver button
        const Color lightGreen = Color(0xFFE6F4EA); // For the client button
        const Color darkGrey = Color(0xFF6B7280);

        return AlertDialog(
          title: const Text('Choose Your Role'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // I'm a Caregiver Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.pushNamed(
                      context,
                      '/caregiver/register',
                    ); // Go to caregiver
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/caregiver.svg',
                        height: 32,
                        width: 32,
                        color: primaryBlue,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "I'm a Caregiver",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryBlue,
                        ),
                      ),
                      const Text(
                        "Join as a professional caregiver",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: darkGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // I'm a Client Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.pushNamed(
                      context,
                      '/seeker/register',
                    ); // Go to client
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightGreen,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/client.svg',
                        height: 32,
                        width: 32,
                        color: primaryGreen,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "I'm a Client",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryGreen,
                        ),
                      ),
                      const Text(
                        "Find care for you or a loved one",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: darkGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF2563EB);
    
    const Color darkGrey = Color(0xFF6B7280);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Caregiver Login'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                SvgPicture.asset('assets/svg/logo.svg', height: 80, width: 80),
            const SizedBox(height: 16),
            // Carely Text
            const Text(
              'Carely',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: primaryBlue,
              ),
            ),
            const SizedBox(height: 8),
            // Tagline
            const Text(
              "We're here to make it better",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: darkGrey,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
                const Text(
                  'Welcome back! Log in to continue.',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
                const SizedBox(height: 30.0),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child:
                        _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                              'Log In',
                              style: TextStyle(fontSize: 18.0),
                            ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        _showUserTypeDialog(context);
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Color(0xFF2563EB)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
