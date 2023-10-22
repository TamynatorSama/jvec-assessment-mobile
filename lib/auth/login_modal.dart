import 'package:contact_app/auth/modal_function.dart';
import 'package:contact_app/auth/requests/auth_request.dart';
import 'package:contact_app/contacts/contact_list_view.dart';
import 'package:contact_app/utils/app_theme.dart';
import 'package:contact_app/utils/custom_button.dart';
import 'package:contact_app/utils/custom_input_field.dart';
import 'package:contact_app/utils/custom_loader.dart';
import 'package:contact_app/utils/feedbacktoast.dart';
import 'package:flutter/material.dart';

class LoginModal extends StatefulWidget {
  const LoginModal({super.key});

  @override
  State<LoginModal> createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 450,
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
                "Login",
                style: AppTheme.headerTextStyle.override(fontSize: 28),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Provide your credentials to access saved contacts securely",
                style: AppTheme.mainTextStyle
                    .override(color: Colors.grey, fontSize: 16),
              ),
              Form(
                key: _formkey,
                  child: Column(
                children: [
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
                    label: "Login",
                    onTap: () async {
                      if (_formkey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        CustomLoader.showLoader(context);
                        await AuthRequest.login(
                          email: emailController.text.trim(),
                          password: passwordController.text,
                        ).then((value) async {
                          await CustomLoader.dismissLoader().then((_) {
                            if (value['status']) {
                              FocusScope.of(context).unfocus();
                              showFeedbackToast(context, value["message"],
                                  type: ToastType.success);

                              return Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ContactListView()),
                                  (Route route) => false);
                            }
                            showFeedbackToast(context, value["message"]);
                          });
                        });
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
                        showSignupModal(context);
                      },
                      child: Text(
                        "Don't have an account? Signup",
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
