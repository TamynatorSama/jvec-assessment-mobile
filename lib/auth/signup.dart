import 'package:contact_app/auth/modal_function.dart';
import 'package:contact_app/auth/requests/auth_request.dart';
import 'package:contact_app/contacts/contact_list_view.dart';
import 'package:contact_app/utils/app_theme.dart';
import 'package:contact_app/utils/custom_button.dart';
import 'package:contact_app/utils/custom_input_field.dart';
import 'package:contact_app/utils/custom_loader.dart';
import 'package:contact_app/utils/feedbacktoast.dart';
import 'package:flutter/material.dart';

class SignupModal extends StatefulWidget {
  const SignupModal({super.key});

  @override
  State<SignupModal> createState() => _SignupModalState();
}

class _SignupModalState extends State<SignupModal> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 550,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Signup",
                style: AppTheme.headerTextStyle.override(fontSize: 28),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Take the first step towards getting started by filling out the required information below.",
                style: AppTheme.mainTextStyle
                    .override(color: Colors.grey, fontSize: 16),
              ),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      CustomInputField(
                        fieldName: "Full Name",
                        controller: nameController,
                        keyboardType: TextInputType.name,
                      ),
                      CustomInputField(
                        fieldName: "Email",
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      CustomInputField(
                        fieldName: "Password",
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        isPasswordField: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        label: "Sign up",
                        onTap: () async {
                          if (_formkey.currentState!.validate()) {
                            CustomLoader.showLoader(context);
                            await AuthRequest.signup(
                                    email: emailController.text.trim(),
                                    password: passwordController.text,
                                    fullName: nameController.text)
                                .then((value) async {
                              showFeedbackToast(context, value["message"]);
                              await CustomLoader.dismissLoader().then((_) {
                                if (value['status']) {
                                  showFeedbackToast(context, value["message"],type: ToastType.success);
                                  return Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ContactListView()));
                                }
                                showFeedbackToast(context, value["message"]);
                              });
                            });

                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const ContactListView()));
                            // AuthRequest.login(email: email, password: password)
                          }
                        },
                        removePadding: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showLoginModal(context);
                          },
                          child: Text(
                            "Already have an account? Login",
                            style: AppTheme.mainTextStyle
                                .override(decoration: TextDecoration.underline),
                          ))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
