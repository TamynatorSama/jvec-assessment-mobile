import 'dart:ui';

import 'package:contact_app/auth/login_modal.dart';
import 'package:contact_app/auth/signup.dart';
import 'package:flutter/material.dart';

Future showLoginModal(BuildContext context)async{
  await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  // constraints: BoxConstraints(
                  //   maxHeight: MediaQuery.of(context).size.height*0.5
                  // ),
                  // isDismissible: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: const LoginModal()),
                );
}
Future showSignupModal(BuildContext context)async{
  await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  // constraints: BoxConstraints(
                  //   maxHeight: MediaQuery.of(context).size.height*0.5
                  // ),
                  // isDismissible: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: const SignupModal()),
                );
}