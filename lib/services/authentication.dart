import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  void signUp(BuildContext context, String email, String password) async {
    try {
      final UserCredential result =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User user = result.user!;

      user.sendEmailVerification();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Usuario creado. Por favor, verifica tu email.')),
      );

      Navigator.of(context)
          .pop(); // Assuming login page is the previous page in the stack
    } catch (e) {
      // Handle signup errors (e.g., invalid email, weak password)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error en la creación del usuario.')),
      );
    }
  }

  void signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null &&
          userCredential.user!.emailVerified == false) {
        // Send email to verify
        await userCredential.user!.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'El email no ha sido verificado. Por favor, revisa tu bandeja de entrada.')));
      }
      // Handle successful login (e.g., navigate to home page)
    } catch (e) {
      // Handle sign-in errors (e.g., invalid credentials)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error signing in. Please try again.')),
      );
    }
  }

  void requestRecovery(BuildContext context, String email) async {
    try {
      // Assuming you're using Firebase Auth, it would look something like this:
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // For demonstration, replace the above line with your actual implementation

      // Step 3: Show feedback to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Check your email to reset your password')),
      );
      // Optionally, navigate to the login page after showing the message
      Navigator.of(context).pushNamed('/login');
    } catch (e) {
      // Handle errors, e.g., show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending reset email: $e')),
      );
    }
  }

  void signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
  }
}
