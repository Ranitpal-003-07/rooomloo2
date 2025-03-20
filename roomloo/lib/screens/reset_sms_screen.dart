import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roomloo/widgets/otp_verification_screen.dart';

class ResetSmsScreen extends StatefulWidget {
  const ResetSmsScreen({super.key});

  @override
  _ResetSmsScreenState createState() => _ResetSmsScreenState();
}

class _ResetSmsScreenState extends State<ResetSmsScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _sendSmsResetLink() {
    if (_formKey.currentState!.validate()) {
      // Simulating API call success
      bool success = true; // Change this based on actual API response

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? "OTP sent to your phone number!"
                : "Failed to send OTP. Try again.",
          ),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );

      if (success) {
        // Navigate to OTP Verification Screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OtpVerificationScreen(phone: _phoneController.text)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/smsbg.jpg', // Replace with your image path
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title
                    const Text(
                      "Reset Your Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                    // Subtitle
                    const Text(
                      "Enter your registered phone number below, and we'll send you an OTP to reset your password.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Phone Input Field
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your phone number",
                          prefixIcon: Icon(Icons.phone_android, color: Colors.grey),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your phone number";
                          } else if (value.length < 10) {
                            return "Enter a valid phone number";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Send OTP Button
                    ElevatedButton(
                      onPressed: _sendSmsResetLink,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Send OTP",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Back Button
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Back to Login",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
