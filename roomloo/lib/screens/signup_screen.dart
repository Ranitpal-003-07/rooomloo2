import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:roomloo/screens/signin_screen.dart';
import 'package:roomloo/themes/theme.dart';
import 'package:roomloo/widgets/custom_scaffold.dart';
import 'package:roomloo/controllers/signup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignupController _signupController = SignupController();
  bool agreePersonalData = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(height: 10),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _signupController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 40.0),

                      // Full Name
                      TextFormField(
                        controller: _signupController.nameController,
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter Full Name' : null,
                        decoration: _inputDecoration('Full Name'),
                      ),
                      const SizedBox(height: 25.0),

                      // Email
                      TextFormField(
                        controller: _signupController.emailController,
                        validator: _signupController.validateEmail,
                        decoration: _inputDecoration('Email'),
                      ),
                      const SizedBox(height: 25.0),

                      // Phone
                      TextFormField(
                        controller: _signupController.phoneController,
                        validator: _signupController.validatePhone,
                        keyboardType: TextInputType.phone,
                        decoration: _inputDecoration('Phone Number'),
                      ),
                      const SizedBox(height: 25.0),

                      // Password
                      TextFormField(
                        controller: _signupController.passwordController,
                        obscureText: true,
                        validator: _signupController.validatePassword,
                        decoration: _inputDecoration('Password'),
                      ),
                      const SizedBox(height: 25.0),


                      // Agreement Checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: agreePersonalData,
                            onChanged: (bool? value) {
                              setState(() {
                                agreePersonalData = value!;
                              });
                            },
                            activeColor: lightColorScheme.primary,
                          ),
                          const Text(
                            'I agree to the processing of ',
                            style: TextStyle(color: Colors.black45),
                          ),
                          Text(
                            'Personal data',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: lightColorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25.0),

                      // Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_signupController.formKey.currentState!
                                    .validate() ||
                                !agreePersonalData) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please fill the form and agree to the terms',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            _signupController.signup(context);
                          },
                          child: const Text('Sign up'),
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Sign Up Divider
                      _buildDivider(),

                      const SizedBox(height: 30.0),

                      // Social Media Icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Logo(Logos.facebook_f),
                          Logo(Logos.twitter),
                          Logo(Logos.google),
                          Logo(Logos.apple),
                        ],
                      ),
                      const SizedBox(height: 25.0),

                      // Already have an account?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(color: Colors.black45),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (e) => const SignInScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: lightColorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Input Decoration Helper
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      label: Text(label),
      hintText: 'Enter $label',
      hintStyle: const TextStyle(color: Colors.black26),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  // Divider Builder
  Widget _buildDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            thickness: 0.7,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Sign up with',
            style: TextStyle(color: Colors.black45),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 0.7,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _signupController.dispose();
    super.dispose();
  }
}
