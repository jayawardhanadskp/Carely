import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    

    // Define colors here or use your custom color file
    const Color primaryBlue = Color(0xFF2563EB);
    const Color primaryGreen = Color(0xFF16A34A);
    const Color lightBlue = Color(0xFFE0F2FE); // For the caregiver button
    const Color lightGreen = Color(0xFFE6F4EA); // For the client button
    const Color darkGrey = Color(0xFF6B7280);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Heart SVG
            SvgPicture.asset(
              'assets/svg/logo.svg', 
              height: 80,
              width: 80,
            ),
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
                fontStyle: FontStyle.italic
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to caregiver registration/login
                  Navigator.pushNamed(context, '/login'); // Use a named route
                  print('Caregiver button pressed');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightBlue, // Use lightBlue
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
                  // Navigate to client registration/login
                  Navigator.pushNamed(context, '/login'); // Use a named route
                  print('Client button pressed');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightGreen, // Use lightGreen
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
                      "Find in-home care for you or a loved one",
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
            const SizedBox(height: 24),
            // Choose your role text
            Text(
              "Choose your role to get started",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: darkGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
