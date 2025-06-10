import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/auth_model/reset_password_model.dart';
import '../../../service/auth/authentication_service.dart';
import 'login_screen.dart';
import 'otp_screen.dart';
import '../../../l10n/app_localizations.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image for the screen
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/servana2.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          Center(
            child: Consumer<AuthenticationService>(
              builder: (context, authService, child) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[900]
                        : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back to login button
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white70
                                  : Colors.black54,
                            ),
                            const SizedBox(width: 5),
                            RichText(
                              text: TextSpan(
                                text: AppLocalizations.of(context)!.back_to,
                                style: TextStyle(
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                                children: <TextSpan>[
                                  const TextSpan(text: " "),
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.login,
                                    style: const TextStyle(color: Colors.teal),
                                  ),
                                  const TextSpan(text: " "),
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.page,
                                    style: TextStyle(
                                      color: Theme.of(context).brightness == Brightness.dark
                                          ? Colors.white70
                                          : Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Title text for Reset Password
                      Text(
                        AppLocalizations.of(context)!.reset_password,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Instruction text
                      Text(
                        AppLocalizations.of(context)!.enter_your_email_or_phone_and_we_will_send_you_a_link_to_get_back_into_your_account,
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white70
                              : Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Email input field
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.email,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Send button
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                          ),
                          onPressed: authService.isLoading
                              ? null
                              : () async {
                            final email = emailController.text.trim();
                            debugPrint("Email entered: $email");

                            if (email.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter your email'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            final resetData = ResetPasswordModel(email: email);
                            debugPrint("Sending JSON: ${jsonEncode(resetData.toJson())}");

                            final success = await authService.resetPassword(resetData);

                            if (success) {
                              // Navigate to OTP screen if successful
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OTPScreen(email: email,),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(authService.errorMessage ?? 'Error occurred'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: authService.isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Text(
                            AppLocalizations.of(context)!.btn_send,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
