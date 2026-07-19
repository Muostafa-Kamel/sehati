import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;
  bool obscurePassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
    });

    try {
      UserCredential credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await credential.user!.updateDisplayName(
        nameController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Account created successfully"),
          ),
        );

        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'email-already-in-use':
          message = 'Email already exists.';
          break;

        case 'invalid-email':
          message = 'Invalid email.';
          break;

        case 'weak-password':
          message = 'Password is too weak.';
          break;

        default:
          message = e.message ?? 'Something went wrong.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  InputDecoration decoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xffEAF4FF),
      prefixIcon: Icon(
        icon,
        color: Colors.teal,
      ),
      suffixIcon: suffix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: Colors.teal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/app_logo.png",
                  height: 150,
                ),

                const SizedBox(height: 20),

                const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 35),

                TextFormField(
                  controller: nameController,
                  decoration: decoration(
                    hint: "Full Name",
                    icon: Icons.person,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name required";
                    }

                    if (value.length < 3) {
                      return "Enter valid name";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: decoration(
                    hint: "Email",
                    icon: Icons.email,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email required";
                    }

                    if (!value.contains("@")) {
                      return "Invalid email";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: decoration(
                    hint: "Password",
                    icon: Icons.lock,
                    suffix: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password required";
                    }

                    if (value.length < 6) {
                      return "Minimum 6 characters";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 35),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: loading ? null : signUp,
                    child: loading
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text(
                      "Create Account",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),

                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Login"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}