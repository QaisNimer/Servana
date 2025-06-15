import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controller/signup_controller.dart';
import '../../../model/auth_model/signup_model.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/signup_widget.dart';
import 'login_client_screen.dart';

enum Gender { male, female }

class SignupWorkerScreen extends StatefulWidget {
  const SignupWorkerScreen({super.key});

  @override
  _SignupWorkerScreenState createState() => _SignupWorkerScreenState();
}

class _SignupWorkerScreenState extends State<SignupWorkerScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  String? _backendFormattedDate;
  Gender? _selectedGender;
  String? _selectedProfession;

  Future<void> _registerUser(BuildContext context) async {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _dateController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _selectedGender == null ||
        _selectedProfession == null) {
      _showErrorDialog(
        context,
        'Please fill in all required fields and select gender and profession',
      );
      return;
    }

    final signUpController = Provider.of<SignUpController>(
      context,
      listen: false,
    );
    final SignUpModel user = SignUpModel(
      email: _emailController.text,
      password: _passwordController.text,
      phonenum: _phoneController.text,
      firstname: _firstNameController.text,
      lastname: _lastNameController.text,
      birthDate: _backendFormattedDate,
      gender: _selectedGender == Gender.male ? "Male" : "Female",
      // You can add: profession: _selectedProfession if backend supports it
    );

    log(
      'Sending user data with birthDate: ${user.birthDate}, gender: ${user.gender}, profession: $_selectedProfession',
    );
    final success = await signUpController.registerUser(user);

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginClientScreen()),
      );
    } else {
      _showErrorDialog(context, signUpController.errorMessage);
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final signUpController = Provider.of<SignUpController>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/signup_worker.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                const SizedBox(height: 80),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color:
                        isDark
                            ? Colors.grey[900]!.withOpacity(0.85)
                            : Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.sign_up,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(
                              context,
                            )!.already_have_an_account,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginClientScreen(),
                                ),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0D47A1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: _firstNameController,
                              labelText:
                                  AppLocalizations.of(context)!.first_name,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextField(
                              controller: _lastNameController,
                              labelText:
                                  AppLocalizations.of(context)!.last_name,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      CustomTextField(
                        controller: _emailController,
                        labelText: AppLocalizations.of(context)!.email,
                        keyboardType: TextInputType.emailAddress,
                        suffixIcon: const Icon(Icons.email),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Gender",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<Gender>(
                              title: Text("Male"),
                              value: Gender.male,
                              groupValue: _selectedGender,
                              onChanged: (Gender? value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<Gender>(
                              title: Text("Female"),
                              value: Gender.female,
                              groupValue: _selectedGender,
                              onChanged: (Gender? value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      CustomTextField(
                        controller: _dateController,
                        labelText: AppLocalizations.of(context)!.birth_date,
                        readOnly: true,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              final formattedDate = DateFormat(
                                "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
                              ).format(pickedDate.toUtc());

                              log('Selected date formatted: $formattedDate');

                              setState(() {
                                _dateController.text = DateFormat(
                                  'dd/MM/yyyy',
                                ).format(pickedDate);
                                _backendFormattedDate = formattedDate;
                              });
                            }
                          },
                        ),
                      ),
                      PhoneInputField(controller: _phoneController),
                      const SizedBox(height: 10),
                      Text(
                        "Profession",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        value: _selectedProfession,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor:
                              isDark ? Colors.grey[800] : Colors.grey[200],
                        ),
                        hint: const Text("Select your profession"),
                        items: const [
                          DropdownMenuItem(
                            value: "Plumber",
                            child: Text("Plumber"),
                          ),
                          DropdownMenuItem(
                            value: "Electrician",
                            child: Text("Electrician"),
                          ),
                          DropdownMenuItem(
                            value: "Gardner",
                            child: Text("Gardner"),
                          ),
                          DropdownMenuItem(
                            value: "Painter",
                            child: Text("Painter"),
                          ),
                          DropdownMenuItem(
                            value: "Cleaning",
                            child: Text("Cleaning"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedProfession = value;
                          });
                        },
                      ),
                      const SizedBox(height: 7),
                      CustomTextField(
                        controller: _passwordController,
                        labelText: AppLocalizations.of(context)!.set_password,
                        isPassword: !_isPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      signUpController.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[900],
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            onPressed: () => _registerUser(context),
                            child: Text(
                              AppLocalizations.of(context)!.register,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
