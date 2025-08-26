import 'package:chat_app_firebase/combonetes/my_button.dart';
import 'package:chat_app_firebase/combonetes/my_text_feilds.dart';
import 'package:chat_app_firebase/service/auth/auth_service.dart';
import 'package:chat_app_firebase/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final conformpasswordcontrololer = TextEditingController();

  // signup user
  void signUp() async {
    if (passwordcontroller.text != conformpasswordcontrololer.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailAndPassword(
        emailcontroller.text.trim(),
        passwordcontroller.text.trim(),
      );

     
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // App Icon
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person_add_alt_1,
                      size: 80, color: Colors.blue.shade600),
                ),
                const SizedBox(height: 20),

                // Title
                Text(
                  "Create Account",
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[900],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Fill the details below to sign up",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.grey[600],
                  ),
                ),

                const SizedBox(height: 40),

                // Email field
                MyTextField(
                  controller: emailcontroller,
                  hintText: 'Enter your email',
                ),
                const SizedBox(height: 20),

                // Password field
                MyTextField(
                  controller: passwordcontroller,
                  hintText: 'Enter your password',
                  obscureText: true,
                ),
                const SizedBox(height: 20),

                // Confirm password field
                MyTextField(
                  controller: conformpasswordcontrololer,
                  hintText: 'Confirm your password',
                  obscureText: true,
                ),
                const SizedBox(height: 30),

                // Register button
                MyButton(
                  onTap: signUp,
                  text: 'Register',
                ),

                const SizedBox(height: 30),

                // Divider
                Row(
                  children: [
                    Expanded(
                        child: Divider(thickness: 0.7, color: Colors.grey[400])),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("or",
                          style: TextStyle(color: Colors.grey[600])),
                    ),
                    Expanded(
                        child: Divider(thickness: 0.7, color: Colors.grey[400])),
                  ],
                ),

                const SizedBox(height: 30),

                // Already have account? → Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ",
                        style: TextStyle(color: Colors.grey[700], fontSize: 15)),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                          fontSize: 15,
                        ),
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
