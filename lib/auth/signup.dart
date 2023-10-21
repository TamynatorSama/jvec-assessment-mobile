import 'package:contact_app/auth/modal_function.dart';
import 'package:contact_app/contacts/contact_list_view.dart';
import 'package:contact_app/utils/app_theme.dart';
import 'package:contact_app/utils/custom_button.dart';
import 'package:contact_app/utils/custom_input_field.dart';
import 'package:flutter/material.dart';

class SignupModal extends StatelessWidget {
  const SignupModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 550,
      padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 24),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Signup",style: AppTheme.headerTextStyle.override(fontSize: 28),),
          const SizedBox(height: 5,),
          Text("Take the first step towards getting started by filling out the required information below.",style: AppTheme.mainTextStyle.override(color: Colors.grey,fontSize: 16),),
          Form(child: Column(
            children: [
              CustomInputField(fieldName: "Full Name", controller: TextEditingController(),keyboardType: TextInputType.name,),
              CustomInputField(fieldName: "Email", controller: TextEditingController(),keyboardType: TextInputType.emailAddress,),
              CustomInputField(fieldName: "Password", controller: TextEditingController(),keyboardType: TextInputType.visiblePassword,isPasswordField: true,),
              const SizedBox(
                height: 20,
              ),
              CustomButton(label: "Sign up", onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const ContactListView()));
              },removePadding: true,),
              const SizedBox(
                height: 10,
              ),
              TextButton(onPressed: (){
                Navigator.pop(context);
                showLoginModal(context);
              }, child: Text("Already have an account? Login",style: AppTheme.mainTextStyle.override(decoration: TextDecoration.underline),))
            ],
          ))
        ],
      ),
    );
  }
}