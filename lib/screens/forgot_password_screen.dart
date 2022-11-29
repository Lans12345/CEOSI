import 'package:ceosi_app/services/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/images.dart';
import '../widgets/button_widget.dart';
import '../widgets/text_widget.dart';
import '../widgets/textformfield_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  final forgotpasswordformKey = GlobalKey<FormState>();

  forgotPassword() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim().toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: forgotpasswordformKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    Images.coesiLogoCompleteAndMaroonBlueText,
                    width: 350,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextformfieldWidget(
                    isEmail: true,
                    textFieldController: _emailController,
                    label: 'Email',
                    colorFill: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ButtonWidget(
                      color: CustomColors.primary,
                      borderRadius: 100,
                      onPressed: () async {
                        if (forgotpasswordformKey.currentState!.validate()) {
                          forgotPassword();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Password Reset Link sent to the email you provided')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Check your credentials')));
                        }
                      },
                      buttonHeight: 50,
                      buttonWidth: 300,
                      textWidget: const NormalTextWidget(
                          color: Colors.white,
                          fontSize: 18,
                          text: 'Send Password Reset Link')),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonWidget(
                      color: CustomColors.primary,
                      borderRadius: 100,
                      onPressed: () async {
                        Navigation(context).goToLoginScreen();
                      },
                      buttonHeight: 50,
                      buttonWidth: 300,
                      textWidget: const NormalTextWidget(
                          color: Colors.white, fontSize: 18, text: 'back'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
