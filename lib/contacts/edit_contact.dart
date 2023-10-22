import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:contact_app/app_provider.dart';
import 'package:contact_app/model/contact_model.dart';
import 'package:contact_app/utils/app_theme.dart';
import 'package:contact_app/utils/constants.dart';
import 'package:contact_app/utils/custom_input_field.dart';
import 'package:contact_app/utils/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditContact extends StatefulWidget {
  final ContactInfo contact;

  const EditContact({super.key, required this.contact});

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  late TextEditingController lastNameController;
  late TextEditingController firstNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController facebookController;
  late TextEditingController emailController;
  late TextEditingController twitterController;

  XFile? image;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late AppProvider provider;
  @override
  void initState() {
    provider = Provider.of<AppProvider>(context, listen: false);
    firstNameController = TextEditingController(text: widget.contact.firstName);
    lastNameController = TextEditingController(text: widget.contact.lastName);
    phoneNumberController =
        TextEditingController(text: widget.contact.phoneNumber);
    emailController = TextEditingController(text: widget.contact.email);
    twitterController = TextEditingController(text: widget.contact.twitter);
    facebookController = TextEditingController(text: widget.contact.firstName);
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
            "Edit Contact",
            style: AppTheme.headerTextStyle.override(fontSize: 22),
          ),
          actions: [
            TextButton(
                onPressed: () async{
                  if (_formkey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    CustomLoader.showLoader(context);
                    ContactInfo newContact = ContactInfo(
                        identifier: widget.contact.identifier,
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        phoneNumber: phoneNumberController.text,
                        twitter: twitterController.text,
                        email: emailController.text,
                        profilePicture: widget.contact.profilePicture,
                        facebook: facebookController.text);
                    await provider
                        .updateContact(newContact, context,
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
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: 250,
                        alignment: Alignment.bottomRight,
                        margin: const EdgeInsets.only(bottom: 30),
                        decoration: image != null
                            ? BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(File(image!.path)),
                                    fit: BoxFit.cover))
                            : BoxDecoration(
                                color: AppTheme.btnColor,
                                image: widget.contact.profilePicture.isNotEmpty
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                            "${baseUrl.replaceAll("api", "")}${widget.contact.profilePicture}",
                                            cacheKey:
                                                widget.contact.profilePicture))
                                    : const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/empty_image.png'))),
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
                      keyboardType: TextInputType.number,
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
