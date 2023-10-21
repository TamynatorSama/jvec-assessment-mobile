import 'package:contact_app/contacts/contact_list_view.dart';
import 'package:contact_app/utils/app_theme.dart';
import 'package:contact_app/utils/custom_button.dart';
import 'package:contact_app/utils/custom_input_field.dart';
import 'package:flutter/material.dart';

class LoginModal extends StatelessWidget {
  const LoginModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 450,
      padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 24),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Login",style: AppTheme.headerTextStyle.override(fontSize: 28),),
          const SizedBox(height: 5,),
          Text("Provide your credentials to access saved contacts securely",style: AppTheme.mainTextStyle.override(color: Colors.grey,fontSize: 16),),
          Form(child: Column(
            children: [
              CustomInputField(fieldName: "Email", controller: TextEditingController(),keyboardType: TextInputType.emailAddress,),
              CustomInputField(fieldName: "Password", controller: TextEditingController(),keyboardType: TextInputType.visiblePassword,isPasswordField: true,),
              const SizedBox(
                height: 20,
              ),
              CustomButton(label: "Login", onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const ContactListView()));
              },removePadding: true,),
              const SizedBox(
                height: 20,
              ),
              Text("Don't have an account? Signup",style: AppTheme.mainTextStyle.override(decoration: TextDecoration.underline),)
            ],
          ))
        ],
      ),
    );
  }
}