import 'package:contact_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactInfoListing extends StatelessWidget {
  final String label;
  final String value;
  final String icon;
  final Color iconBgColor;
  const ContactInfoListing({required this.icon,required this.iconBgColor,required this.label,required this.value,super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CircleAvatar(
        radius: 25,
        backgroundColor: iconBgColor,
        child: SvgPicture.string(icon),
      ),
      const SizedBox(width: 20,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,style: AppTheme.mainTextStyle.override(color:Colors.grey),),
          Text(value,style: AppTheme.headerTextStyle.override(fontSize: 18),)
        ],
      )
    ],
    );
  }
}