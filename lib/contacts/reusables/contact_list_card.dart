import 'package:contact_app/utils/app_theme.dart';
import 'package:contact_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ContactListCard extends StatelessWidget {
  final String label;
  final String value;
  final String? image;
  final Function() onTap;
  const ContactListCard(
      {this.image,
      required this.label,
      required this.onTap,
      required this.value,
      super.key,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: image!=null?null:AppTheme.btnColor,
              backgroundImage: image!=null? CachedNetworkImageProvider( "${baseUrl.replaceAll("api", "")}$image",cacheKey: image,):null,
              child: Offstage(
                offstage: image!=null,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTheme.mainTextStyle.override(color: Colors.grey),
                ),
                Text(
                  value,
                  style: AppTheme.headerTextStyle.override(fontSize: 18),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
