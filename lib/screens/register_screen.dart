import 'package:ceosi_app/repositories/auth_repository.dart';
import 'package:ceosi_app/screens/ceosi_rewards/widgets/dialogs/error_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/colors.dart';
import '../constants/images.dart';
import '../services/navigation.dart';
import '../widgets/button_widget.dart';
import '../widgets/text_widget.dart';
import '../widgets/textformfield_widget.dart';
import 'ceosi_rewards/widgets/buttons/dropdown_item_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  int _dropdownValue = 0;

  String roleCategory = 'Flutter Developer';
  String departmentCategory = 'Flutter Deparment';

  registorValidator(WidgetRef ref) async {
    if (_passwordController.text != _confirmPasswordController.text) {
      showDialogWidget('Password do not match!');
    } else if (_passwordController.text == '' || _emailController.text == '') {
      showDialogWidget('Invalid Input!');
    } else if (_passwordController.text.length < 6) {
      showDialogWidget('Password too short!');
    } else {
      try {
        AuthRepository().userSignUp(
            _nameController.text,
            _emailController.text,
            _passwordController.text,
            _confirmPasswordController.text,
            roleCategory,
            departmentCategory,
            '');
        goToHomeScreen();
      } catch (e) {
        showDialogWidget(e.toString());
      }
    }
  }

  showDialogWidget(String error) {
    return showDialog(
      context: context,
      builder: ((context) {
        return ErrorDialog(
            color: Colors.white,
            caption: error,
            onPressed: () {
              Navigator.of(context).pop();
            });
      }),
    );
  }

  goToHomeScreen() {
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                Images.coesiLogoCompleteAndMaroonBlueText,
                width: 350,
              ),
              const SizedBox(
                height: 10,
              ),
              TextformfieldWidget(
                isObscure: false,
                textFieldController: _nameController,
                label: 'Name',
                colorFill: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              TextformfieldWidget(
                isObscure: false,
                textFieldController: _emailController,
                label: 'Email',
                colorFill: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              TextformfieldWidget(
                isObscure: true,
                textFieldController: _passwordController,
                label: 'Password',
                colorFill: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              TextformfieldWidget(
                isObscure: true,
                textFieldController: _confirmPasswordController,
                label: 'Confirm Password',
                colorFill: Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                    child: DropdownButton(
                      underline: Container(color: Colors.transparent),
                      iconEnabledColor: Colors.black,
                      isExpanded: true,
                      value: _dropdownValue,
                      items: [
                        DropdownMenuItem(
                          onTap: () {
                            roleCategory = 'Flutter Developer';
                            departmentCategory = 'Flutter Department';
                          },
                          value: 0,
                          child: DropDownItem(label: 'Flutter Developer'),
                        ),
                        DropdownMenuItem(
                          onTap: () {
                            roleCategory = 'Frontend Developer';
                            departmentCategory = 'Frontend Department';
                          },
                          value: 1,
                          child: DropDownItem(label: 'Frontend Developer'),
                        ),
                        DropdownMenuItem(
                          onTap: () {
                            roleCategory = 'Backend Developer';
                            departmentCategory = 'Backend Department';
                          },
                          value: 2,
                          child: DropDownItem(label: 'Backend Developer'),
                        ),
                        DropdownMenuItem(
                          onTap: () {
                            roleCategory = 'Quality Assurance';
                            departmentCategory = 'Quality Assurance Department';
                          },
                          value: 3,
                          child: DropDownItem(label: 'Quality Assurance'),
                        ),
                        DropdownMenuItem(
                          onTap: () {
                            roleCategory = 'Admin';
                            departmentCategory = 'Admin Department';
                          },
                          value: 4,
                          child: DropDownItem(label: 'Admin'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _dropdownValue = int.parse(value.toString());
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Consumer(
                builder: (context, ref, child) {
                  return ButtonWidget(
                      color: CustomColors.primary,
                      borderRadius: 100,
                      onPressed: () async {
                        registorValidator(ref);
                      },
                      buttonHeight: 50,
                      buttonWidth: 300,
                      textWidget: const NormalTextWidget(
                          color: Colors.white, fontSize: 18, text: 'Register'));
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const NormalTextWidget(
                      color: Colors.black,
                      fontSize: 14,
                      text: 'Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigation(context).goToLoginScreen();
                    },
                    child: const BoldTextWidget(
                        color: Colors.black, fontSize: 18, text: 'Login'),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
