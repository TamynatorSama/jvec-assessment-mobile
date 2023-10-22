import 'dart:math';

import 'package:contact_app/app_provider.dart';
import 'package:contact_app/contacts/edit_contact.dart';
import 'package:contact_app/contacts/reusables/action_btn.dart';
import 'package:contact_app/contacts/reusables/contact_info_listing.dart';
import 'package:contact_app/model/contact_model.dart';
import 'package:contact_app/utils/app_theme.dart';
import 'package:contact_app/utils/constants.dart';
import 'package:contact_app/utils/custom_loader.dart';
import 'package:contact_app/utils/svg_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:provider/provider.dart';

class ContactDetails extends StatelessWidget {
  final String contactId;
  const ContactDetails({super.key, required this.contactId});

  @override
  Widget build(BuildContext context) {
    List<String> imagePath = [
      "assets/images/1.jpeg",
      "assets/images/2.jpeg",
      "assets/images/3.jpeg",
      "assets/images/4.jpeg",
      "assets/images/5.jpeg",
      "assets/images/6.jpeg",
      "assets/images/7.jpeg",
      "assets/images/6.jpeg"
    ];
    Size size = MediaQuery.of(context).size;
    return Consumer<AppProvider>(builder: (context, provider, child) {
      ContactInfo currentContact = provider.contacts
          .where((element) => element.identifier == contactId)
          .first;
      return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: Stack(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                  left: 20, top: MediaQuery.of(context).padding.top),
              width: double.maxFinite,
              height: size.height * 0.5,
              decoration: BoxDecoration(
                  image: currentContact.profilePicture.isNotEmpty
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              "${baseUrl.replaceAll("api", "")}${currentContact.profilePicture}",
                              cacheKey: currentContact.profilePicture))
                      : DecorationImage(
                          image: AssetImage(
                              imagePath[Random().nextInt(imagePath.length)]),
                          fit: BoxFit.cover,
                        )),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size.height * 0.75,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Transform.translate(
                    offset: const Offset(0, -50),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                                color: AppTheme.backgroundColor,
                                borderRadius: BorderRadius.circular(10),
                                image: currentContact.profilePicture.isNotEmpty
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                            "${baseUrl.replaceAll("api", "")}${currentContact.profilePicture}",
                                            cacheKey:
                                                currentContact.profilePicture))
                                    : const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/empty_image.png')),
                                border: Border.all(
                                    width: 2,
                                    color:
                                        const Color.fromARGB(255, 89, 89, 89))),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "${currentContact.firstName} ${currentContact.lastName}",
                            style: AppTheme.headerTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            currentContact.phoneNumber,
                            style: AppTheme.mainTextStyle
                                .override(color: Colors.grey, fontSize: 13),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 20,
                            children: [
                              ActionBtn(
                                  icons: svgIcons['edit']!,
                                  callback: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => EditContact(
                                                  contact: currentContact,
                                                )));
                                  }),
                              ActionBtn(
                                  icons: svgIcons['share']!,
                                  callback: () async {
                                    FlutterShareMe().shareToSystem(
                                        msg:
                                            "Contact ${currentContact.firstName} ${currentContact.lastName}\n ${currentContact.share()}");
                                  }),
                              ActionBtn(
                                  icons: svgIcons['delete']!,
                                  callback: () async {
                                    CustomLoader.showLoader(context);
                                    await provider
                                        .deleteContact(contactId, context)
                                        .then((value) {
                                      CustomLoader.dismissLoader();
                                      if (value) {
                                        Navigator.pop(context);
                                      }
                                    });
                                  })
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Expanded(
                            child: Wrap(
                              runSpacing: 20,
                              children: [
                                ContactInfoListing(
                                    icon: svgIcons['whatsapp']!,
                                    iconBgColor: Colors.green,
                                    label: "Whatsapp",
                                    value: currentContact.phoneNumber),
                                if (currentContact.email != null &&
                                    currentContact.email!.isNotEmpty)
                                  ContactInfoListing(
                                      icon: svgIcons['gmail']!,
                                      iconBgColor: Colors.red,
                                      label: "Email",
                                      value: currentContact.email!),
                                if (currentContact.twitter != null &&
                                    currentContact.twitter!.isNotEmpty)
                                  ContactInfoListing(
                                      icon: svgIcons['x']!,
                                      iconBgColor: Colors.black,
                                      label: "Twitter(X)",
                                      value: currentContact.twitter!),
                                if (currentContact.facebook != null &&
                                    currentContact.facebook!.isNotEmpty)
                                  ContactInfoListing(
                                      icon: svgIcons['facebook']!,
                                      iconBgColor: Colors.blue,
                                      label: "Facebook",
                                      value: currentContact.facebook!)
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            )
          ],
        ),
      );
    });
  }
}
