// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phone; // Phone number from previous screen

  const OtpVerificationScreen({super.key, required this.phone});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(4, (index) => FocusNode());

  void _verifyOtp() {
    String otpCode = _otpControllers.map((e) => e.text).join();
    
    if (otpCode.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter the complete OTP."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    bool success = otpCode == "1234"; // Mock verification

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? "OTP Verified! Password reset successful." : "Invalid OTP. Try again.",
        ),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );

    if (success) {
      Navigator.pop(context); // Go back to login screen
    }
  }

  void _resendOtp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("New OTP sent to your phone."),
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/otpbg.jpg', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),

          // Dark overlay for readability
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),

          // Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  const Text(
                    "Verify OTP",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Subtitle
                  Text(
                    "Enter the OTP sent to ${widget.phone}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // OTP Input Fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Container(
                        width: 45,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _otpControllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 5) {
                              _focusNodes[index + 1].requestFocus();
                            }
                          },
                          decoration: const InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),

                  // Verify OTP Button
                  ElevatedButton(
                    onPressed: _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Verify OTP",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Resend OTP
                  TextButton(
                    onPressed: _resendOtp,
                    child: const Text(
                      "Resend OTP",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),

                  // Back Button
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Back",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
