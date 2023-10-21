import 'package:contact_app/utils/app_theme.dart';
import 'package:contact_app/utils/custom_input_field.dart';
import 'package:flutter/material.dart';

class EditContact extends StatelessWidget {
  const EditContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppTheme.backgroundColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.fromLTRB(24, 15, 15, 15),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          title: Text(
            "Edit Contact",
            style: AppTheme.headerTextStyle.override(fontSize: 22),
          ),
          actions: [
            TextButton(onPressed: (){}, child: Text("Save",style: AppTheme.headerTextStyle.override(fontSize: 16),))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              24,
              MediaQuery.of(context).padding.top + 5,
              24,
              0),
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            
                  Container(
                    width: double.maxFinite,
                    height: 250,
                    alignment: Alignment.bottomRight,
                    margin: const EdgeInsets.only(bottom: 30),
                    // color: AppTheme.btnColor,
                    decoration: BoxDecoration(
                      color: AppTheme.btnColor,
                      image: const DecorationImage(image: AssetImage('assets/images/empty_image.png'))
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.camera_alt_rounded,color: Colors.white,),
                    ),
                  ),
            
                  CustomInputField(fieldName:"First Name", controller: TextEditingController(),hintText: "Firstname",),
                  CustomInputField(fieldName:"Last Name", controller: TextEditingController(),hintText: "Lastname",),
                  CustomInputField(fieldName:"Email", controller: TextEditingController(),keyboardType: TextInputType.emailAddress,hintText: "Example@email.com",),
                  CustomInputField(fieldName:"Twitter", controller: TextEditingController(),hintText: "@TwitterHandle",),
                  CustomInputField(fieldName:"FaceBook", controller: TextEditingController(),hintText: "@FacebookHandle",),
                  SizedBox(
                    height: MediaQuery.of(context).padding.top + 10,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
