import 'package:contact_app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class ContactListCard extends StatelessWidget {
  final String label;
  final String value;
  final String? image;
  const ContactListCard({this.image,required this.label,required this.value,super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom:20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: AppTheme.btnColor,
          child: const Icon(Icons.person,color: Colors.white,),
        ),
        const SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,style: AppTheme.mainTextStyle.override(color:Colors.grey),),
            Text(value,style: AppTheme.headerTextStyle.override(fontSize: 18),)
          ],
        ),
        
      ],
      ),
    );
  }
}