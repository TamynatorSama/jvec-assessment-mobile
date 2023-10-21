import 'dart:math';

import 'package:contact_app/contacts/reusables/action_btn.dart';
import 'package:contact_app/contacts/reusables/contact_info_listing.dart';
import 'package:contact_app/utils/app_theme.dart';
import 'package:contact_app/utils/svg_icons.dart';
import 'package:flutter/material.dart';

class ContactDetails extends StatelessWidget {
  const ContactDetails({super.key});

  @override
  Widget build(BuildContext context) {

    List<String> imagePath = ["assets/images/1.jpeg","assets/images/2.jpeg","assets/images/3.jpeg","assets/images/4.jpeg","assets/images/5.jpeg","assets/images/6.jpeg","assets/images/7.jpeg","assets/images/6.jpeg"];
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor ,
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 20,top: MediaQuery.of(context).padding.top),
            width: double.maxFinite,
            height: size.height * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(imagePath[Random().nextInt(imagePath.length)]),fit: BoxFit.cover,)
            ),
            child: IconButton(
              onPressed: (){},
              icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
              ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height*0.75,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: AppTheme.backgroundColor,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
              ),
              child: Transform.translate(
                offset: const Offset(0, -50),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:24.0),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2,color: Colors.white)
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                        Text("John Doe",style: AppTheme.headerTextStyle,textAlign: TextAlign.center,),
                        Text("09063976031",style: AppTheme.mainTextStyle.override(color: Colors.grey,fontSize: 13),),
                        const SizedBox(
                        height: 20,
                      ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 20,
                          children: [
                            ActionBtn(icons: svgIcons['edit']!, callback: (){}),
                            ActionBtn(icons: svgIcons['share']!, callback: (){}),
                            ActionBtn(icons: svgIcons['delete']!, callback: (){})
                          ],
                        ),
                        const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: Wrap(
                          runSpacing: 20,
                          children: [
                            ContactInfoListing(icon: svgIcons['whatsapp']!, iconBgColor: Colors.green, label: "Whatsapp", value: "+2349063976031"),
                            ContactInfoListing(icon: svgIcons['gmail']!, iconBgColor: Colors.red, label: "Email", value: "kolawoletamilore1@gmail.com"),
                            ContactInfoListing(icon: svgIcons['x']!, iconBgColor: Colors.black, label: "Twitter(X)", value: "@tamynator"),
                            ContactInfoListing(icon: svgIcons['facebook']!, iconBgColor: Colors.blue, label: "Facebook", value: "@tamynator")
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
  }
}