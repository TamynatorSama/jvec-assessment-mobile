import 'dart:ui';

import 'package:contact_app/auth/login_modal.dart';
import 'package:contact_app/utils/app_theme.dart';
import 'package:contact_app/utils/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          SvgPicture.asset(
            'assets/images/contact.svg',
          ),
          // const SizedBox(height: ,),
          Text(
            "Welcome",
            style: AppTheme.headerTextStyle.override(fontSize: 32),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Experience the convenience of a unified contact management solution, where you can effortlessly create, access, and organize all your contacts in one user-friendly app, eliminating the hassle of scattered information."
              // "Effortlessly manage your contacts in a single, user-friendly app. Say goodbye to scattered information and experience seamless organization."
              // "Easily create, access, and organize all your contacts in one place with our user-friendly app, simplifying contact management."
              // "Streamline your communication by effortlessly creating, accessing, and organizing all your contacts in one place with the user-friendly contact app. Say goodbye to scattered contact information and welcome the convenience of a centralized hub for seamless management."
              ,
              style: AppTheme.mainTextStyle.override(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          CustomButton(
              label: "Continue",
              onTap: () {
                showModalBottomSheet(
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
              }),
          SizedBox(
            height: MediaQuery.of(context).padding.top + 10,
          )
        ],
      ),
    );
  }
}
