import 'package:doctor_appointment/components/login_form.dart';
import 'package:doctor_appointment/components/sign_up_form.dart';
import 'package:doctor_appointment/components/social_button.dart';
import 'package:doctor_appointment/utils/config.dart';
import 'package:doctor_appointment/utils/text.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isSignIn = true;

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppText.enText['welcome_text']!,
                  style: const TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                Text(
                  isSignIn
                      ? AppText.enText['signIn_text']!
                      : AppText.enText['register_text']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,

                // Login components here
                isSignIn ? const LoginForm() : const SignUpForm(),

                Config.spaceSmall,
                isSignIn
                    ? Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            AppText.enText['forgot-password']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    : Container(),

                // Add social button sign in
                const Spacer(),
                Center(
                  child: Text(
                    AppText.enText['social-login']!,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
                Config.spaceSmall,

                // Social button
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialButton(social: 'google'),
                    SocialButton(social: 'facebook'),
                    Config.spaceSmall,
                  ],
                ),
                Config.spaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isSignIn
                          ? AppText.enText['signUp_text']!
                          : AppText.enText['registered_text']!,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isSignIn = !isSignIn;
                        });
                      },
                      child: Text(
                        isSignIn ? "Sign Up" : "Sign In",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
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
