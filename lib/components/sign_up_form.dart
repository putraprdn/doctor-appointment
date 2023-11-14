import 'dart:developer';

import 'package:doctor_appointment/core.dart';
import 'package:doctor_appointment/models/auth_model.dart';
import 'package:doctor_appointment/providers/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.text,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Username',
              labelText: 'Username',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.person_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),

          Config.spaceSmall,

          // Email
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Email Address',
              labelText: 'Email',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),

          Config.spaceSmall,

          // Password
          TextFormField(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: obsecurePass,
            cursorColor: Config.primaryColor,
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.lock_outlined),
              prefixIconColor: Config.primaryColor,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obsecurePass = !obsecurePass;
                  });
                },
                icon: obsecurePass
                    ? const Icon(
                        Icons.visibility_off_outlined,
                        color: Colors.black38,
                      )
                    : const Icon(
                        Icons.visibility_outlined,
                        color: Config.primaryColor,
                      ),
              ),
            ),
          ),

          Config.spaceSmall,

          Consumer<AuthModel>(
            builder: (context, auth, child) {
              return Button(
                width: double.infinity,
                title: 'Sign Up',
                onPressed: () async {
                  final userRegistration = await DioProvider().registerUser(
                    _nameController.text,
                    _emailController.text,
                    _passController.text,
                  );

                  log('userRegistration: ${userRegistration}');

                  if (userRegistration) {
                    // Get token
                    final token = await DioProvider()
                        .getToken(_emailController.text, _passController.text);

                    if (token) {
                      log('token: ${token}');
                      auth.loginSuccess();
                      if (mounted) Navigator.of(context).pushNamed('main');
                    }
                  } else {
                    // Display error message
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid email or password'),
                        ),
                      );
                    }
                  }
                },
                disable: false,
              );
            },
          )
        ],
      ),
    );
  }
}
