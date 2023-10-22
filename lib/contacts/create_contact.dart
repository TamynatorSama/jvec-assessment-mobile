import 'dart:io';

import 'package:contact_app/app_provider.dart';
import 'package:contact_app/model/contact_model.dart';
import 'package:contact_app/utils/app_theme.dart';
import 'package:contact_app/utils/custom_input_field.dart';
import 'package:contact_app/utils/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateContact extends StatefulWidget {
  const CreateContact({super.key});

  @override
  State<CreateContact> createState() => _CreateContactState();
}

class _CreateContactState extends State<CreateContact> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController facebookController = TextEditingController();

  XFile? image;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late AppProvider provider;
  @override
  void initState() {
    provider = Provider.of<AppProvider>(context, listen: false);
    super.initState();
  }

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
            "Create Contact",
            style: AppTheme.headerTextStyle.override(fontSize: 22),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    CustomLoader.showLoader(context);
                    ContactInfo newContact = ContactInfo(
                        identifier: "",
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        phoneNumber: phoneNumberController.text,
                        twitter: twitterController.text,
                        email: emailController.text,
                        facebook: facebookController.text);
                    await provider
                        .createNewContact(newContact, context,
                            image: image?.path)
                        .then((value) async{
                      FocusScope.of(context).unfocus();
                      await CustomLoader.dismissLoader();
                      if (value) {
                        Navigator.pop(context);
                      }
                    });
                  }
                },
                child: Text(
                  "Save",
                  style: AppTheme.headerTextStyle.override(fontSize: 16),
                ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              24, MediaQuery.of(context).padding.top + 5, 24, 0),
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        ImagePicker imagePicker = ImagePicker();
                        await imagePicker
                            .pickImage(source: ImageSource.gallery)
                            .then((value) {
                          if (value != null) {
                            image = value;
                            setState(() {});
                          }
                        });

                        //       ImagePicker.platform.
                        //       await FilePicker.platform
                        //     .pickFiles(type: FileType.image)
                        //     .then((value) {
                        //   if (value == null) {
                        //     return;
                        //   }
                        //   provider.uploadFile(value.files.first.path!, context);
                        // });
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: 250,
                        alignment: Alignment.bottomRight,
                        margin: const EdgeInsets.only(bottom: 30),
                        // color: AppTheme.btnColor,
                        decoration: image == null
                            ? BoxDecoration(
                                color: AppTheme.btnColor,
                                image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/empty_image.png')))
                            : BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(File(image!.path)),
                                    fit: BoxFit.cover)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    CustomInputField(
                      fieldName: "First Name",
                      controller: firstNameController,
                      hintText: "Firstname",
                    ),
                    CustomInputField(
                      fieldName: "Last Name",
                      controller: lastNameController,
                      hintText: "Lastname",
                    ),
                    CustomInputField(
                      fieldName: "Phone Number",
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                      hintText: "123456789",
                    ),
                    CustomInputField(
                      fieldName: "Email",
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Example@email.com",
                      validator: (_) => null,
                    ),
                    CustomInputField(
                      fieldName: "Twitter",
                      controller: twitterController,
                      hintText: "@TwitterHandle",
                      validator: (_) => null,
                    ),
                    CustomInputField(
                      fieldName: "FaceBook",
                      controller: facebookController,
                      hintText: "@FacebookHandle",
                      validator: (_) => null,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.top + 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
